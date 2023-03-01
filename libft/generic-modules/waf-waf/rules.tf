#------------------------------------------------------------------------------
# WAF Rules
#------------------------------------------------------------------------------
## 1.
## OWASP Top 10 A1
## Mitigate SQL Injection Attacks
## Matches attempted SQLi patterns in the URI, QUERY_STRING, BODY, COOKIES

resource "aws_waf_rule" "mitigate_sqli" {
  name        = "${var.waf_prefix}-generic-mitigate-sqli"
  metric_name = replace("${var.waf_prefix}genericmitigatesqli", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_sql_injection_match_set.sql_injection_match_set.id
    negated = false
    type    = "SqlInjectionMatch"
  }
}

resource "aws_waf_sql_injection_match_set" "sql_injection_match_set" {
  name = "${var.waf_prefix}-generic-detect-sqli"

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "HEADER"
      data = "Authorization"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "HEADER"
      data = "Authorization"
    }
  }
}

## 2.
## OWASP Top 10 A2
## Blacklist bad/hijacked JWT tokens or session IDs
## Matches the specific values in the cookie or Authorization header
## for JWT it is sufficient to check the signature

resource "aws_waf_rule" "detect_bad_auth_tokens" {
  name        = "${var.waf_prefix}-generic-detect-bad-auth-tokens"
  metric_name = replace("${var.waf_prefix}genericdetectbadauthtokens", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_byte_match_set.match_auth_tokens.id
    negated = false
    type    = "ByteMatch"
  }
}

resource "aws_waf_byte_match_set" "match_auth_tokens" {
  name = "${var.waf_prefix}-generic-match-auth-tokens"

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = ".TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ"
    positional_constraint = "ENDS_WITH"

    field_to_match {
      type = "HEADER"
      data = "authorization"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "example-session-id"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }
}

## 3.
## OWASP Top 10 A3
## Mitigate Cross Site Scripting Attacks
## Matches attempted XSS patterns in the URI, QUERY_STRING, BODY, COOKIES

resource "aws_waf_rule" "mitigate_xss" {
  name        = "${var.waf_prefix}-generic-mitigate-xss"
  metric_name = replace("${var.waf_prefix}genericmitigatexss", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_xss_match_set.xss_match_set.id
    negated = false
    type    = "XssMatch"
  }
}

resource "aws_waf_xss_match_set" "xss_match_set" {
  name = "${var.waf_prefix}-generic-detect-xss"

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }
}


## 4.
## OWASP Top 10 A4
## Path Traversal, LFI, RFI
## Matches request patterns designed to traverse filesystem paths, and include
## local or remote files

resource "aws_waf_rule" "detect_rfi_lfi_traversal" {
  name        = "${var.waf_prefix}-generic-detect-rfi-lfi-traversal"
  metric_name = replace("${var.waf_prefix}genericdetectrfilfitraversal", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_byte_match_set.match_rfi_lfi_traversal.id
    negated = false
    type    = "ByteMatch"
  }
}

resource "aws_waf_byte_match_set" "match_rfi_lfi_traversal" {
  name = "${var.waf_prefix}-generic-match-rfi-lfi-traversal"

  byte_match_tuples {
    text_transformation   = "HTML_ENTITY_DECODE"
    target_string         = "://"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "HTML_ENTITY_DECODE"
    target_string         = "../"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "://"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "../"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "HTML_ENTITY_DECODE"
    target_string         = "://"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "HTML_ENTITY_DECODE"
    target_string         = "../"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "://"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "../"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "URI"
    }
  }
}

## 5.
## OWASP Top 10 A4
## Privileged Module Access Restrictions
## Restrict access to the admin interface to known source IPs only
## Matches the URI prefix, when the remote IP isn't in the whitelist

resource "aws_waf_rule" "detect_admin_access" {
  name        = "${var.waf_prefix}-generic-detect-admin-access"
  metric_name = replace("${var.waf_prefix}genericdetectadminaccess", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_ipset.admin_remote_ipset.id
    negated = true
    type    = "IPMatch"
  }

  predicates {
    data_id = aws_waf_byte_match_set.match_admin_url.id
    negated = false
    type    = "ByteMatch"
  }
}

resource "aws_waf_ipset" "admin_remote_ipset" {
  name = "${var.waf_prefix}-generic-match-admin-remote-ip"
  dynamic "ip_set_descriptors" {
    for_each = var.admin_remote_ipset

    content {
      type  = "IPV4"
      value = ip_set_descriptors.value
    }
  }
}

resource "aws_waf_byte_match_set" "match_admin_url" {
  name = "${var.waf_prefix}-generic-match-admin-url"

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "/admin"
    positional_constraint = "STARTS_WITH"

    field_to_match {
      type = "URI"
    }
  }
}

## 6.
## OWASP Top 10 A5
## PHP Specific Security Misconfigurations
## Matches request patterns designed to exploit insecure PHP/CGI configuration

resource "aws_waf_rule" "detect_php_insecure" {
  name        = "${var.waf_prefix}-generic-detect-php-insecure"
  metric_name = replace("${var.waf_prefix}genericdetectphpinsecure", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_byte_match_set.match_php_insecure_uri.id
    negated = false
    type    = "ByteMatch"
  }

  predicates {
    data_id = aws_waf_byte_match_set.match_php_insecure_var_refs.id
    negated = false
    type    = "ByteMatch"
  }
}

resource "aws_waf_byte_match_set" "match_php_insecure_uri" {
  name = "${var.waf_prefix}-generic-match-php-insecure-uri"

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "php"
    positional_constraint = "ENDS_WITH"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "/"
    positional_constraint = "ENDS_WITH"

    field_to_match {
      type = "URI"
    }
  }
}

resource "aws_waf_byte_match_set" "match_php_insecure_var_refs" {
  name = "${var.waf_prefix}-generic-match-php-insecure-var-refs"

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "_ENV["
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "auto_append_file="
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "disable_functions="
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "auto_prepend_file="
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "safe_mode="
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "_SERVER["
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "allow_url_include="
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "open_basedir="
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "QUERY_STRING"
    }
  }
}

## 7.
## OWASP Top 10 A7
## Mitigate abnormal requests via size restrictions
## Enforce consistent request hygene, limit size of key elements

resource "aws_waf_rule" "restrict_sizes" {
  name        = "${var.waf_prefix}-generic-restrict-sizes"
  metric_name = replace("${var.waf_prefix}genericrestrictsizes", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_size_constraint_set.size_restrictions.id
    negated = false
    type    = "SizeConstraint"
  }
}

resource "aws_waf_size_constraint_set" "size_restrictions" {
  name = "${var.waf_prefix}-generic-size-restrictions"

  #
  # Note: we are disabling this constraint because uploads will be affected.
  #
  # size_constraints {
  #   text_transformation = "NONE"
  #   comparison_operator = "GT"
  #   size                = "4096"
  #
  #   field_to_match {
  #     type = "BODY"
  #   }
  # }

  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "GT"
    size                = "4093"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }
  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "GT"
    size                = "1024"

    field_to_match {
      type = "QUERY_STRING"
    }
  }
  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "GT"
    size                = "512"

    field_to_match {
      type = "URI"
    }
  }
}

## 8.
## OWASP Top 10 A8
## CSRF token enforcement example
## Enforce the presence of CSRF token in request header

resource "aws_waf_rule" "enforce_csrf" {
  name        = "${var.waf_prefix}-generic-enforce-csrf"
  metric_name = replace("${var.waf_prefix}genericenforcecsrf", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_byte_match_set.match_csrf_method.id
    negated = false
    type    = "ByteMatch"
  }

  predicates {
    data_id = aws_waf_size_constraint_set.csrf_token_set.id
    negated = true
    type    = "SizeConstraint"
  }
}

resource "aws_waf_byte_match_set" "match_csrf_method" {
  name = "${var.waf_prefix}-generic-match-csrf-method"

  byte_match_tuples {
    text_transformation   = "LOWERCASE"
    target_string         = "post"
    positional_constraint = "EXACTLY"

    field_to_match {
      type = "METHOD"
    }
  }
}

resource "aws_waf_size_constraint_set" "csrf_token_set" {
  name = "${var.waf_prefix}-generic-match-csrf-token"

  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "EQ"
    size                = "36"

    field_to_match {
      type = "HEADER"
      data = var.rule_csrf_header
    }
  }
}

## 9.
## OWASP Top 10 A9
## Server-side includes & libraries in webroot
## Matches request patterns for webroot objects that shouldn't be directly accessible

resource "aws_waf_rule" "detect_ssi" {
  name        = "${var.waf_prefix}-generic-detect-ssi"
  metric_name = replace("${var.waf_prefix}genericdetectssi", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_byte_match_set.match_ssi.id
    negated = false
    type    = "ByteMatch"
  }
}

resource "aws_waf_byte_match_set" "match_ssi" {
  name = "${var.waf_prefix}-generic-match-ssi"

  byte_match_tuples {
    text_transformation   = "LOWERCASE"
    target_string         = ".cfg"
    positional_constraint = "ENDS_WITH"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "LOWERCASE"
    target_string         = ".backup"
    positional_constraint = "ENDS_WITH"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "LOWERCASE"
    target_string         = ".ini"
    positional_constraint = "ENDS_WITH"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "LOWERCASE"
    target_string         = ".conf"
    positional_constraint = "ENDS_WITH"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "LOWERCASE"
    target_string         = ".log"
    positional_constraint = "ENDS_WITH"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "LOWERCASE"
    target_string         = ".bak"
    positional_constraint = "ENDS_WITH"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "LOWERCASE"
    target_string         = ".config"
    positional_constraint = "ENDS_WITH"

    field_to_match {
      type = "URI"
    }
  }

  byte_match_tuples {
    text_transformation   = "URL_DECODE"
    target_string         = "/includes"
    positional_constraint = "STARTS_WITH"

    field_to_match {
      type = "URI"
    }
  }
}

## 10.
## Generic
## IP Blacklist
## Matches IP addresses that should not be allowed to access content

resource "aws_waf_rule" "detect_blacklisted_ips" {
  name        = "${var.waf_prefix}-generic-detect-blacklisted-ips"
  metric_name = replace("${var.waf_prefix}genericdetectblacklistedips", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_ipset.blacklisted_ips.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_ipset" "blacklisted_ips" {
  name = "${var.waf_prefix}-generic-match-blacklisted-ips"
  dynamic "ip_set_descriptors" {
    for_each = var.blacklisted_ips

    content {
      type  = "IPV4"
      value = ip_set_descriptors.value
    }
  }
}

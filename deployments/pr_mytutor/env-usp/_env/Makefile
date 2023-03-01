# To switch environments run:
#   make dev-env
#   make prod-env
# dev-env.incl, prod-env.incl should exist.
$(shell mkdir -p profiles)
$(shell ln -sf ../../_profiles/env-uss-dev.incl profiles/)
$(shell ln -sf ../../_profiles/env-uss-staging.incl profiles/)
$(shell ln -sf ../../_profiles/env-uss-prod.incl profiles/)
$(shell ln -sf ../../_profiles/env-uss-experimental.incl profiles/)
$(shell ln -sf ../../_profiles/env-uss-qa.incl profiles/)

# Default settings.
include ../_profiles/default.incl

#
# Common rules and dependencies
#
ROOT_DIR=$(shell git rev-parse --show-toplevel)

include $(ROOT_DIR)/framework/incl/Makefile.incl

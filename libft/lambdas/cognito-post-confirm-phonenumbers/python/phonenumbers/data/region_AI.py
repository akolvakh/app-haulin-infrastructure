"""Auto-generated file, do not edit by hand. AI metadata"""
from ..phonemetadata import NumberFormat, PhoneNumberDesc, PhoneMetadata

PHONE_METADATA_AI = PhoneMetadata(id='AI', country_code=1, international_prefix='011',
    general_desc=PhoneNumberDesc(national_number_pattern='(?:264|[58]\\d\\d|900)\\d{7}', possible_length=(10,), possible_length_local_only=(7,)),
    fixed_line=PhoneNumberDesc(national_number_pattern='264(?:292|4(?:6[12]|9[78]))\\d{4}', example_number='2644612345', possible_length=(10,), possible_length_local_only=(7,)),
    mobile=PhoneNumberDesc(national_number_pattern='264(?:235|4(?:69|76)|5(?:3[6-9]|8[1-4])|7(?:29|72))\\d{4}', example_number='2642351234', possible_length=(10,), possible_length_local_only=(7,)),
    toll_free=PhoneNumberDesc(national_number_pattern='8(?:00|33|44|55|66|77|88)[2-9]\\d{6}', example_number='8002123456', possible_length=(10,)),
    premium_rate=PhoneNumberDesc(national_number_pattern='900[2-9]\\d{6}', example_number='9002123456', possible_length=(10,)),
    personal_number=PhoneNumberDesc(national_number_pattern='52(?:3(?:[2-46-9][02-9]\\d|5(?:[02-46-9]\\d|5[0-46-9]))|4(?:[2-478][02-9]\\d|5(?:[034]\\d|2[024-9]|5[0-46-9])|6(?:0[1-9]|[2-9]\\d)|9(?:[05-9]\\d|2[0-5]|49)))\\d{4}|52[34][2-9]1[02-9]\\d{4}|5(?:00|2[125-7]|33|44|66|77|88)[2-9]\\d{6}', example_number='5002345678', possible_length=(10,)),
    pager=PhoneNumberDesc(national_number_pattern='264724\\d{4}', example_number='2647241234', possible_length=(10,), possible_length_local_only=(7,)),
    national_prefix='1',
    national_prefix_for_parsing='1|([2457]\\d{6})$',
    national_prefix_transform_rule='264\\1',
    leading_digits='264',
    mobile_number_portable_region=True)

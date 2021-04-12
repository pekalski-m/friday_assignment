*** Settings ***
# Resources
Resource  ..${/}CommonLibrary.resource

*** Variables ***
${MONTH_YEAR_FIRST_REGISTERED_FIELD}  //*[@name='monthYearFirstRegistered']
${MONTH_YEAR_OWNER_REGISTERED_FIELD}  //*[@name='monthYearOwnerRegistered']

*** Keywords ***
Enter First Registration Date
  [Arguments]  ${first_registration_date}
  CommonLibrary.Input Text Into Field  ${MONTH_YEAR_FIRST_REGISTERED_FIELD}  ${first_registration_date}

Enter Owner Registration Date
  [Arguments]  ${owner_registration_date}
  CommonLibrary.Input Text Into Field  ${MONTH_YEAR_OWNER_REGISTERED_FIELD}  ${owner_registration_date}
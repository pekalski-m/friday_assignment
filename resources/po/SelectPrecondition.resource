*** Settings ***
# Standard libraries
Library  DateTime

# External libraries
Library  SeleniumLibrary

# Resources
Resource  ..${/}CommonLibrary.resource

*** Variables ***
${PRECONDITION_BUTTON}              //*[@name='precondition']
${PRECONDITION_BUYING_CAR_BUTTON}   ${PRECONDITION_BUTTON} [@value='buyingCar']
${PRECONDITION_KEEPING_CAR_BUTTON}  ${PRECONDITION_BUTTON} [@value='keepingCar']

${INCEPTION_DATE_INPUT}  //*[@name='inceptionDate']

${INCEPTION_DATE_TOO_FAR_ERROR_MSG}  Hups! Dieses Datum liegt zu weit in der Zukunft. Bitte überprüfe deine Eingabe.

*** Keywords ***
Set Buying Or Keeping Car
  [Arguments]  ${buying_car}=${True}
  BuiltIn.Run Keyword If  '${buying_car}' == '${True}'
  ...  CommonLibrary.Click Element When Visible And Enabled  ${PRECONDITION_BUYING_CAR_BUTTON}
  ...  ELSE
  ...  CommonLibrary.Click Element When Visible And Enabled  ${PRECONDITION_KEEPING_CAR_BUTTON}

Set Inception Date
  [Documentation]  This keyword sets inception date basing on the offset value (in days).
  ...              It does nothing if offset is not provided. 
  [Arguments]  ${inception_date_offset}=${EMPTY}
  BuiltIn.Return From Keyword If  '${inception_date_offset}' == '${EMPTY}'

  ${inception_date_value} =  DateTime.Get Current Date  increment=${inception_date_offset}d  result_format=%d.%m.%Y
  CommonLibrary.Input Text Into Field  ${INCEPTION_DATE_INPUT}  ${inception_date_value}
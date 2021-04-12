*** Settings ***
# Resources
Resource  ..${/}CommonLibrary.resource

*** Variables ***
${REGISTERED_OWNER_BUTTON}      //*[@name='registeredOwner']
${REGISTERED_OWNER_YES_BUTTON}  ${REGISTERED_OWNER_BUTTON} [@value='Yes']
${REGISTERED_OWNER_NO_BUTTON}   ${REGISTERED_OWNER_BUTTON} [@value='No']

${CAR_CONDITION_BUTTON}       //*[@name='newOrUsed']
${CAR_CONDITION_NEW_BUTTON}   ${CAR_CONDITION_BUTTON} [@value='brandNew']
${CAR_CONDITION_USED_BUTTON}  ${CAR_CONDITION_BUTTON} [@value='used']

*** Keywords ***
Select Registered Owner
  [Arguments]  ${registered_owner}=${True}
  BuiltIn.Run Keyword If  '${registered_owner}' == '${True}'
  ...  CommonLibrary.Click Element When Visible And Enabled  ${REGISTERED_OWNER_YES_BUTTON}
  ...  ELSE
  ...  CommonLibrary.Click Element When Visible And Enabled  ${REGISTERED_OWNER_NO_BUTTON}

Select Car Condition
  [Arguments]  ${is_car_new}=${False}
  BuiltIn.Run Keyword If  '${is_car_new}' == '${False}'
  ...  CommonLibrary.Click Element When Visible And Enabled  ${CAR_CONDITION_NEW_BUTTON}
  ...  ELSE
  ...  CommonLibrary.Click Element When Visible And Enabled  ${CAR_CONDITION_USED_BUTTON}
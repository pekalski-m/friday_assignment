*** Settings ***
# Resources
Resource  ..${/}CommonLibrary.resource

*** Keywords ***
Select Model
  [Arguments]  ${car_model}
  CommonLibrary.Select From Single Click List Field  ${car_model}
*** Settings ***
# Resources
Resource  ..${/}CommonLibrary.resource

*** Keywords ***
Select Engine Power
  [Arguments]  ${engine_power}
  CommonLibrary.Select From Single Click List Field  ${engine_power}
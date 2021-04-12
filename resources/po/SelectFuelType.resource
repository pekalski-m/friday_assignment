*** Settings ***
# Resources
Resource  ..${/}CommonLibrary.resource

*** Keywords ***
Select Fuel Type
  [Arguments]  ${fuel_type}
  CommonLibrary.Select From Single Click List Field  ${fuel_type}
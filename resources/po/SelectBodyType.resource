*** Settings ***
# Resources
Resource  ..${/}CommonLibrary.resource

*** Keywords ***
Select Body Type
  [Arguments]  ${body_type}
  CommonLibrary.Select From Single Click List Field  ${body_type}
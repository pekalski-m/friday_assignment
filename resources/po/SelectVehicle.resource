*** Settings ***
# Resources
Resource  ..${/}CommonLibrary.resource

*** Keywords ***
Select Car Make
  [Arguments]  ${car_make}
  CommonLibrary.Select From Single Click List Field  ${car_make}
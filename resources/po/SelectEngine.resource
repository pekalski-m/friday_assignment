*** Settings ***
# Standard libraries
Library  String

# Resources
Resource  ..${/}CommonLibrary.resource

*** Keywords ***
Select Engine
  [Arguments]  ${engin_info}
  ${engine_type} =  String.Fetch From Left  ${engin_info}  ;
  ${engine_description} =  String.Fetch From Right  ${engin_info}  ;
  CommonLibrary.Select From Single Click List Field  ${engine_type}  ${engine_description}
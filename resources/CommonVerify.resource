*** Settings ***
Documentation  A resource file with commonly used verification keywords.

# Standard libraries
Library  String

# External libraries
Library  SeleniumLibrary

# Resources
Resource  CommonLibrary.resource

*** Keywords ***
Verify Element Is Displayed
  [Documentation]  This keyword verifies if element with given locator is displayed on the page.
  [Arguments]  ${element_locator}  ${timeout}=${MEDIUM_TIMEOUT}
  SeleniumLibrary.Wait Until Element Is Visible  ${element_locator}  ${timeout}

Verify Error Message Is Displayed
  [Documentation]  This keyword verifies if error message if displayed on the page.
  ...              It also verifies if message text has proper color.
  [Arguments]  ${expected_error_message}  ${timeout}=${SHORT_TIMEOUT}
  ${element_with_error_message_locator} =  BuiltIn.Set Variable  //*[normalize-space(.)='${expected_error_message}']
  
  SeleniumLibrary.Wait Until Element Is Visible  ${element_with_error_message_locator}  ${timeout}
  ${web_element} =  SeleniumLibrary.Get WebElement  ${element_with_error_message_locator}
  ${element_color} =  BuiltIn.Call Method  ${web_element}  value_of_css_property  color

  ${color_model} =  String.Fetch From Left  ${element_color}  (
  BuiltIn.Should Be Equal As Strings  ${ERROR_COLOR_VALUE_${color_model}}  ${element_color} 
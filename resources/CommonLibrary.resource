*** Settings ***
Documentation  A resource file with commonly used keywords and variables.
...
...            It wraps keyword calls from imported (not standard) libraries and turns
...            them into more succinct and descriptive keywords.

# Standard libraries
Library  OperatingSystem
Library  String

# External libraries
Library  SeleniumLibrary

*** Variables ***
# These variables can be overridden from the command line as needed
## Browser related variables
${BROWSER}  chrome

## Timeouts
${INTERVAL}        1s
${SHORT_TIMEOUT}   3s
${MEDIUM_TIMEOUT}  10s
${LONG TIMEOUT}    1m

## URL to the home page
${HOME_PAGE_URL}  https://hello.friday.de/

## HTML elements locators
${PAGE_ROOT_SECTION}      root
${BANER_LOCATOR}          //*[contains(@class, 'uc-banner-content')]
${SUBMIT_BUTTON}          //*[@type='submit']
${ACCEPT_COOKIES_BUTTON}  uc-btn-accept-banner

# Color values
${ERROR_COLOR_VALUE_RGBA}  rgba(54, 49, 69, 1)
${ERROR_COLOR_VALUE_RGB}   rgb(54, 49, 69)

# Other variables
${TEST_DATA_PATH}  ${EXECDIR}${/}resources${/}test_data${/}

*** Keywords ***
#=================================
# Browser related keywords
#=================================
Open Web Browser
  [Documentation]  This keyword opens web browser and maximizes window.
  SeleniumLibrary.Open Browser  browser=${BROWSER}
  SeleniumLibrary.Maximize Browser Window

Close Web Browser
  [Documentation]  This keyword closes web browser.
  SeleniumLibrary.Close Browser

#=================================
# Page related keywords
#=================================
Go To Home Page
  [Documentation]  This keyword navigate to the home page.
  SeleniumLibrary.Go To  ${HOME_PAGE_URL}
  CommonLibrary.Wait Until Page Displays Element  ${PAGE_ROOT_SECTION}  ${MEDIUM_TIMEOUT}

Capture Web Page Screenshot
  [Documentation]  This keyword captures screenshot of the web page.
  [Arguments]  ${screenshot_file_name}=${TEST_NAME}
  SeleniumLibrary.Capture Page Screenshot  ${screenshot_file_name}_{index}.png

#=================================
# Cookies related keywords
#=================================
Accept Cookies If Asked
  [Documentation]  This keyword checks if cookie consent banner is visible.
  ...              If yes, it accepts cookies. Otherwise, it does nothing.
  ${cookies_banner_appeared} =  BuiltIn.Run Keyword And Return Status
  ...  SeleniumLibrary.Wait Until Element Is Visible  ${BANER_LOCATOR}  ${SHORT_TIMEOUT}

  BuiltIn.Run Keyword If  ${cookies_banner_appeared} == ${True}  CommonLibrary.Accept Cookies

Accept Cookies
  [Documentation]  This keyword clicks accept cookies button.
  CommonLibrary.Click Element When Visible And Enabled  ${ACCEPT_COOKIES_BUTTON}
  SeleniumLibrary.Wait Until Element Is Not Visible  ${BANER_LOCATOR}  ${SHORT_TIMEOUT}

Remove All Cookies
  [Documentation]  This keyword removes all cookies.
  SeleniumLibrary.Delete All Cookies

#=================================
# HTML elements interaction keywords
#=================================
Click Submit Button
  [Documentation]  This keyword clicks submit button.
  CommonLibrary.Click Element When Visible And Enabled  ${SUBMIT_BUTTON}

Click Element When Visible And Enabled
  [Documentation]  This keyword waits until element with given locator is visible and enabled,
  ...              then it clicks that element.
  [Arguments]  ${element_locator}  ${timeout}=${SHORT_TIMEOUT}
  CommonLibrary.Wait Until Element Is Visible And Enabled  ${element_locator}  ${timeout}
  SeleniumLibrary.Click Element  ${element_locator}

Input Text Into Field
  [Documentation]  This keyword inputs given text into inoput field.
  [Arguments]  ${input_field_locator}  ${input_value}  ${timeout}=${SHORT_TIMEOUT}
  CommonLibrary.Wait Until Element Is Visible And Enabled  ${input_field_locator}  ${timeout}
  ${input_value} =  BuiltIn.Convert To String  ${input_value}
  SeleniumLibrary.Input Text  ${input_field_locator}  ${input_value}

Select From Single Click List Field
  [Documentation]  This keyword selects option from the single click list field.
  ...              Arguments:
  ...                  button_label: option to be selected.
  ...                  description: additional description that appears in some single click lists; empty by default.
  ...                  timeout: timeout.
  [Arguments]  ${button_label}  ${description}=${EMPTY}  ${timeout}=${SHORT_TIMEOUT}
  ${single_click_button_locator} =  BuiltIn.Set Variable  //*[normalize-space(.)='${button_label}']/ancestor::button

  ${single_click_button_locator} =  BuiltIn.Set Variable If  '${description}' == '${EMPTY}'
  ...  ${single_click_button_locator}
  ...  ${single_click_button_locator} //*[normalize-space(.)='${description}']

  CommonLibrary.Click Element When Visible And Enabled  ${single_click_button_locator}

#=================================
# Wait until keywords
#=================================
Wait Until Element Is Visible And Enabled
  [Documentation]  This keyword waits until element with given locator is visible and enabled.
  [Arguments]  ${element_locator}  ${timeout}=${SHORT_TIMEOUT}
  SeleniumLibrary.Wait Until Element Is Visible  ${element_locator}  ${timeout}
  SeleniumLibrary.Wait Until Element Is Enabled  ${element_locator}  ${timeout}

Wait Until Page Displays Element
  [Documentation]  This keyword waits until element with given locator appears on the page.
  [Arguments]  ${element_locator}  ${timeout}=${SHORT_TIMEOUT}
  SeleniumLibrary.Wait Until Element Is Visible  ${element_locator}  ${timeout}

Wait Until Page Displays Text
  [Documentation]  This keyword waits until given text is displayed on the page.
  [Arguments]  ${text}  ${timeout}=${MEDIUM_TIMEOUT}
  SeleniumLibrary.Wait Until Page Contains  ${text}  ${timeout}
  
#=================================
# Other keywords
#=================================
Clear Output Directory
  [Documentation]  This keyword removes all files from the output directory,
  ...              except for the output xml file, which is already used and can't be removed.
  ${output_dir_files} =  OperatingSystem.List Files In Directory  ${OUTPUT_DIR}
  FOR  ${file}  IN  @{output_dir_files}
    BuiltIn.Continue For Loop If  '${OUTPUT_FILE}' == '${OUTPUT_DIR}${/}${file}'
    OperatingSystem.Remove File  ${OUTPUT_DIR}${/}${file}
  END
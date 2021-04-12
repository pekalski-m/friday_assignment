*** Settings ***
Documentation  Tests to verify if UI allows to select valid cars data.
...            One extra test (TC-2) that verifies if error message is displayed
...            when inception date is invalid.
...            More details: https://gist.github.com/MMore/da79169c45608684d921bff092f3831a

# Standard libraries
Library  OperatingSystem
Library  String

Resource  ..${/}resources${/}CommonLibrary.resource
Resource  ..${/}resources${/}CommonVerify.resource

Resource  ..${/}resources${/}po${/}EnterBirthDate.resource
Resource  ..${/}resources${/}po${/}EnterRegistrationDate.resource
Resource  ..${/}resources${/}po${/}SelectBodyType.resource
Resource  ..${/}resources${/}po${/}SelectEngine.resource
Resource  ..${/}resources${/}po${/}SelectEnginePower.resource
Resource  ..${/}resources${/}po${/}SelectFuelType.resource
Resource  ..${/}resources${/}po${/}SelectModel.resource
Resource  ..${/}resources${/}po${/}SelectPrecondition.resource
Resource  ..${/}resources${/}po${/}SelectRegisteredOwner.resource
Resource  ..${/}resources${/}po${/}SelectVehicle.resource

Resource  ${TEST_DATA_PATH}CarDataVariables.resource

Suite Setup     Setup Suite
Suite Teardown  CommonLibrary.Close Web Browser

*** Variables ***
@{VALID_TEST_DATA_FILES}          @{EMPTY}
${CURRENT_TEST_DATA_FILE}         ${EMPTY}
${CURRENT_TEST_DATA_FILE_WO_EXT}  ${EMPTY}
${CAR_DATA}                       ${EMPTY}

*** Test Cases ***
TC-1 UI Shall Allow To Select Valid Cars Data
  [Template]  Test Case 1 Template
  FOR  ${test_data_file}  IN  @{VALID_TEST_DATA_FILES}
    ${test_data_file}
  END

TC-2 UI Shall Display Error Message If Inception Date Is Too Far
  BuiltIn.Set Suite Variable  ${CURRENT_TEST_DATA_FILE}  invalid_inception_date_offset.py
  Setup Test
  Set Preconditions

  CommonVerify.Verify Error Message Is Displayed  ${INCEPTION_DATE_TOO_FAR_ERROR_MSG}
  CommonLibrary.Capture Web Page Screenshot  TEST-CASE-2

*** Keywords ***
Setup Suite
  # Get names of the test data files containing valid cars data.
  @{data_files} =  OperatingSystem.List Files In Directory  ${TEST_DATA_PATH}  *_valid_data*.py
  BuiltIn.Set Suite Variable  @{VALID_TEST_DATA_FILES}  @{data_files}

  # Clear results directory
  CommonLibrary.Clear Output Directory
  
  # Open web browser
  CommonLibrary.Open Web Browser

Setup Test
  CommonLibrary.Remove All Cookies
  CommonLibrary.Go To Home Page
  CommonLibrary.Accept Cookies If Asked

  BuiltIn.Import Variables  ${TEST_DATA_PATH}${CURRENT_TEST_DATA_FILE}

  ${current_test_data_file_without_extension} =  String.Fetch From Left  ${CURRENT_TEST_DATA_FILE}  .
  BuiltIn.Set Suite Variable  ${CURRENT_TEST_DATA_FILE_WO_EXT}  ${current_test_data_file_without_extension}

Test Case 1 Template
  [Arguments]  ${car_data_file_name}
  BuiltIn.Set Suite Variable  ${CURRENT_TEST_DATA_FILE}  ${car_data_file_name}
  Setup Test

  Set Preconditions
  CommonLibrary.Click Submit Button
  Set Registered Owner Data
  CommonLibrary.Click Submit Button
  Select Vehicle
  Select Car Model
  Select Car Body Type
  Select Car Fuel Type
  Select Car Engine Power
  Select Car Engine
  Enter Car Registration Date
  CommonLibrary.Click Submit Button
  Check If Birth Date Input Field Is Displayed

Set Preconditions
  SelectPrecondition.Set Buying Or Keeping Car  ${CAR_DATA}[${BUYING_CAR_KEY}]
  SelectPrecondition.Set Inception Date  ${CAR_DATA}[${INCEPTION_DATE_OFFSET_KEY}]
  CommonLibrary.Capture Web Page Screenshot  ${CURRENT_TEST_DATA_FILE_WO_EXT}_preconditions

Set Registered Owner Data
  SelectRegisteredOwner.Select Registered Owner  ${CAR_DATA}[${REGISTERED_OWNER_KEY}]
  SelectRegisteredOwner.Select Car Condition  ${CAR_DATA}[${IS_CAR_NEW_KEY}]
  CommonLibrary.Capture Web Page Screenshot  ${CURRENT_TEST_DATA_FILE_WO_EXT}_registered_owner_data

Select Vehicle
  SelectVehicle.Select Car Make  ${CAR_DATA}[${MAKE_KEY}]
  CommonLibrary.Capture Web Page Screenshot  ${CURRENT_TEST_DATA_FILE_WO_EXT}_vehicle

Select Car Model
  SelectModel.Select Model  ${CAR_DATA}[${MODEL_KEY}]
  CommonLibrary.Capture Web Page Screenshot  ${CURRENT_TEST_DATA_FILE_WO_EXT}_car_model

Select Car Body Type
  ${car_body_type_to_select} =  BuiltIn.Set Variable  ${CAR_DATA}[${BODY_TYPE_KEY}]
  BuiltIn.Run Keyword Unless  '${car_body_type_to_select}' == '${EMPTY}'  BuiltIn.Run Keywords
  ...  SelectBodyType.Select Body Type  ${car_body_type_to_select}
  ...  AND
  ...  CommonLibrary.Capture Web Page Screenshot  ${CURRENT_TEST_DATA_FILE_WO_EXT}_body_type

Select Car Fuel Type
  ${fuel_type_to_select} =  BuiltIn.Set Variable  ${CAR_DATA}[${FUEL_TYPE_KEY}]
  BuiltIn.Run Keyword Unless  '${fuel_type_to_select}' == '${EMPTY}'  BuiltIn.Run Keywords
  ...  SelectFuelType.Select Fuel Type  ${fuel_type_to_select}
  ...  AND
  ...  CommonLibrary.Capture Web Page Screenshot  ${CURRENT_TEST_DATA_FILE_WO_EXT}_fuel_type

Select Car Engine Power
  ${car_engine_power_to_select} =  BuiltIn.Set Variable  ${CAR_DATA}[${ENGINE_POWER_KEY}]
  BuiltIn.Run Keyword Unless  '${car_engine_power_to_select}' == '${EMPTY}'  BuiltIn.Run Keywords
  ...  SelectEnginePower.Select Engine Power  ${car_engine_power_to_select}
  ...  AND
  ...  CommonLibrary.Capture Web Page Screenshot  ${CURRENT_TEST_DATA_FILE_WO_EXT}_engine_power

Select Car Engine
  ${car_engine_to_select} =  BuiltIn.Set Variable  ${CAR_DATA}[${ENGINE_KEY}]
  BuiltIn.Run Keyword Unless  '${car_engine_to_select}' == '${EMPTY}'  BuiltIn.Run Keywords
  ...  SelectEngine.Select Engine  ${car_engine_to_select}
  ...  AND
  ...  CommonLibrary.Capture Web Page Screenshot  ${CURRENT_TEST_DATA_FILE_WO_EXT}_engine

Enter Car Registration Date
  EnterRegistrationDate.Enter First Registration Date  ${CAR_DATA}[${FIRSTR_EGISTERED_KEY}]

  BuiltIn.Run Keyword If  '${CAR_DATA}[${BUYING_CAR_KEY}]' != '${True}' and '${CAR_DATA}[${IS_CAR_NEW_KEY}]' == '${True}'
  ...  EnterRegistrationDate.Enter Owner Registration Date  ${CAR_DATA}[${OWNER_EGISTERED_KEY}]

  CommonLibrary.Capture Web Page Screenshot  ${CURRENT_TEST_DATA_FILE_WO_EXT}_registration_date

Check If Birth Date Input Field Is Displayed
  CommonVerify.Verify Element Is Displayed  ${BIRTH_DATE_FIELD}
  CommonLibrary.Capture Web Page Screenshot  ${CURRENT_TEST_DATA_FILE_WO_EXT}_birth_date
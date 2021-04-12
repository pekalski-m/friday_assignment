# FRIDAY QA Candidate Assignment

UI tests that go through [sales funnel](https://hello.friday.de/) page and select car data.

Test Suite contains two Test Cases:

1. Test that selects valid car data and stops when it comes to enter date of birth (*Wann wurdest du geboren?*). It picks three different car brands, each brand with three different car models.

2. Extra test case that enters invalid inception date and verifies if error message is displayed.


## **Table of Contents**

- [Technology Stack](#Technology-Stack)
- [Project Structure](#Project-Structure)
- [Environment Setup](#Environment-Setup)
  * [Install Python 3](#Install-Python-3)
  * [Install Robot Framework](#Install-Robot-Framework)
  * [Install Robot Framework Selenium Library](#Install-Robot-Framework-Selenium-Library)
  * [Install Web Browser](#Install-Web-Browser)
  * [Install The Browser Web Drivers](#Install-The-Browser-Web-Drivers)
- [Launching Robot Tests](#Launching-Robot-Tests)
- [Results](#Results)
- [To-Do](#To-Do)
- [Author](#Author)

## Technology Stack

Project is created with:

- Python 3.x
- Robot Framework 3.2
- Robot Framework SeleniumLibrary 5.x

## Project Structure

```
.
├── resources                      # Resources used in tests
│   ├──po                          # Page Object files
│   ├──test_data                   # Data used in tests
│   ├──CommonLibrary.resource      # File with commonly used keywords and variables
│   └──CommonVerify.resource       # File with generic verification keywords
├── results                        # All test results
├── tests                          # Test Suites
└── README.md
```

## Environment Setup

### Install Python 3

1. Download newest Python 3 from the [Python downloads page](https://www.python.org/downloads/).

2. Run installer as administrator.

3. Check the box to add python to your path and process with installation.

4. When installation is complete, verify your installation by opening a command prompt and executing the following command:

   ```
   python -V
   ```

5. Verify the PIP (Python Package Manager) is installed by executing the following command:

   ```
   pip -V
   ```

### Install Robot Framework

1. Open a command prompt as administrator and execute the following command:

   ```
   pip install robotframework==3.2
   ```

2. Verify the version of Robot Framework installed by executing the following command:

   ```
   robot --version
   ```

### Install Robot Framework Selenium Library

1. Open a command as administrator prompt and execute the following command:

   ```
   pip install robotframework-seleniumlibrary
   ```

2. Verify that Robot Framework Selenium library is installed by executing the following command:

   ```
   pip list
   ```

### Install Web Browser

Install the browser you wish to test your application with by going to the browser vendors website and downloading the installer.

Google Chrome is a recommended web browser. 

> ⚠️ Microsoft Internet Explorer is not supported and tests execution will not start on this web browser. 

### Install The Browser Web Drivers

Selenium library is used to interact with the web browsers you use during testing. It requires a specific web browser driver executable to connect to the browser that you wish to test. 

Commonly used drivers include:

- Google ChromeDriver for Chrome: https://chromedriver.chromium.org
- GeckoDriver for Firefox: https://github.com/mozilla/geckodriver/releases
- WebDriver for Microsoft Edge: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/#downloads
- OperaDriver for Opera: https://github.com/operasoftware/operachromiumdriver/releases

> ⚠️ Make sure to download the web browser drivers for the specific browser version that you have installed on your workstation.

To install the driver(s), simply download them to a directory, unzip them if necessary, and add that directory to your system path. To do this, perform the following steps (on Windows 10):

1. In the Windows search field enter **env** and select **Edit the system environment variables**.
2. Click the "**Environment Variables...**" button.
3. Find the **PATH** variable under System variables. Select it and click the "**Edit...**" button.
4. Click the "**New**" button and enter path to your directory containing web drivers (for example *c:\web-drivers*).
5. Dismiss all of the dialogs by clicking "**OK**" button.

> 🛈 It is good practice to put the drivers in a location that is easy to find such as *c:\web-drivers* because the drivers will need to stay in sync with the browser that they interact with. As the browsers are updated, the corresponding web driver may need to be updated as well or tests may begin to fail.

## Launching Robot Tests

To run tests you need to open command prompt in the main folder of the project and execute the following command:

```
robot -d results tests
```

By default, tests are executed on the Google Chrome (with the visible UI). If you want to use a different web browser or Google Chrome in the headless mode, you need to extend launching command:

```
robot -v BROWSER:<browser> -d results tests
```

where `<browser>` should be replaced by the name of web browser that you want to use. Some of the most popular options:

| Browser          | `<browser>`              |
| ---------------- | ------------------------ |
| Firefox          | firefox, ff              |
| Google Chrome    | googlechrome, chrome, gc |
| Headless Firefox | headlessfirefox          |
| Headless Chrome  | headlesschrome           |
| Edge             | edge                     |
| Opera            | opera                    |

## Results

All executed test suites and test cases, as well as their statuses, are shown there in real time in the command prompt. Sample output from the command line can be found below.

```
================================================================================
Friday Assignment                                                               
================================================================================
Friday Assignment.Tests                                                         
================================================================================
Friday Assignment.Tests.SelectCarData :: Tests to verify if UI allows to sele...
================================================================================
TC-1 UI Shall Allow To Select Valid Cars Data                           | PASS |
--------------------------------------------------------------------------------
TC-2 UI Shall Display Error Message If Inception Date Is Too Far        | PASS |
--------------------------------------------------------------------------------
Friday Assignment.Tests.SelectCarData :: Tests to verify if UI allow... | PASS |
2 critical tests, 2 passed, 0 failed
2 tests total, 2 passed, 0 failed
================================================================================
Friday Assignment.Tests                                                 | PASS |
2 critical tests, 2 passed, 0 failed
2 tests total, 2 passed, 0 failed
================================================================================
Friday Assignment                                                       | PASS |
2 critical tests, 2 passed, 0 failed
2 tests total, 2 passed, 0 failed
================================================================================
Output:  \friday_assignment\results\output.xml
Log:     \friday_assignment\results\log.html
Report:  \friday_assignment\results\report.html
```

Command line output is very limited. Detailed results, as well as screenshots taken during tests execution, are located in the ***results*** directory. Most detailed report can be found in the ***log.html*** file.

## To-Do

- CI integration
- [Jacoco](https://www.jacoco.org/jacoco/trunk/index.html) html report integration

## Author

Michal Pekalski

☎ +48 507 087 237

✉️ pekalskim@gmail.com

🌐 [LinkedIn Profile](https://www.linkedin.com/in/micha%C5%82-p%C4%99kalski-79453a134/)

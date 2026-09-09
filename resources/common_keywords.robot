*** Settings ***
Documentation       Global common keywords
Library             SeleniumLibrary
Variables           ../config/env.py

*** Variables ***
${BROWSER}                  chrome
${LOGIN_URL_PATH}           /login
${DASHBOARD_URL_PATH}       /

*** Keywords ***
Start Browser Session
    [Arguments]    ${url}=${BASE_URL}    ${browser_type}=${BROWSER}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --start-maximized
    Open Browser    ${url}    ${browser_type}    options=${options}
    Set Selenium Timeout        ${SELENIUM_TIMEOUT}
    Set Selenium Implicit Wait  ${IMPLICIT_WAIT}

Close Browser Session
    Close All Browsers

Navigate Directly To Route
    [Arguments]    ${route_path}
    Go To    ${BASE_URL}${route_path}

Verify Redirected To Dashboard
    Wait Until Location Contains    ${DASHBOARD_URL_PATH}    timeout=10s

Verify Redirected To Login
    Wait Until Location Contains    /login    timeout=10s

Navigate Browser Back
    Execute Javascript    window.history.back();

Clear Local And Session Storage
    Execute Javascript    window.localStorage.clear();
    Execute Javascript    window.sessionStorage.clear();
    Delete All Cookies
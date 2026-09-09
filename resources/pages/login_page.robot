*** Settings ***
Documentation       Page Object Model for the Login page.
Library             SeleniumLibrary
Resource            ../common_keywords.robot

*** Variables ***
${INPUT_EMAIL}              id:email
${INPUT_PASSWORD}           id:password
${BTN_SIGN_IN}              css:button[type="submit"]

*** Keywords ***
Open Login Page
    Go To    ${BASE_URL}${LOGIN_URL_PATH}
    Wait Until Element Is Visible    ${INPUT_EMAIL}    timeout=10s
    Wait Until Element Is Visible    ${INPUT_PASSWORD}    timeout=10s
    Wait Until Element Is Visible    ${BTN_SIGN_IN}    timeout=10s

Input Email Field
    [Arguments]    ${email}
    Clear Element Text    ${INPUT_EMAIL}
    Run Keyword If    '${email}' != '${EMPTY}'    Input Text    ${INPUT_EMAIL}    ${email}

Input Password Field
    [Arguments]    ${password}
    Clear Element Text    ${INPUT_PASSWORD}
    Run Keyword If    '${password}' != '${EMPTY}'    Input Password    ${INPUT_PASSWORD}    ${password}

Click Sign in Button
    Click Button    ${BTN_SIGN_IN}

Submit Login Form
    [Arguments]    ${email}    ${password}
    Input Email Field        ${email}
    Input Password Field     ${password}
    Click Sign in Button
    BuiltIn.Sleep            2s

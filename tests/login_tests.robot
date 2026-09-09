*** Settings ***
Documentation       Authentication Test Suite
Resource            ../resources/common_keywords.robot
Resource            ../resources/pages/login_page.robot
Suite Setup         Start Browser Session
Suite Teardown      Close Browser Session
Test Setup          Open Login Page
Variables           ../config/env.py

*** Variables ***

*** Test Cases ***
PI-1: Verify Successful User Login With Valid Credentials
    [Tags]             Authentication    Smoke    Critical
    login_page.Input Email Field           ${VALID_EMAIL}
    login_page.Input Password Field        ${VALID_PASSWORD}
    common_keywords.Verify Redirected To Dashboard

PI-2.1: Verify login rejection with non registered email
    [Tags]             Authentication    Security    Negative
    login_page.Submit Login Form       unregistered@email.com    ${VALID_PASSWORD}
    common_keywords.Verify Redirected To Login

PI-2.2: Verify login rejection with invalid password
    [Tags]            Authentication    Security    Negative
    login_page.Submit Login Form       ${VALID_EMAIL}    InvalidPassword123!
    common_keywords.Verify Redirected To Login



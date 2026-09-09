*** Settings ***
Documentation       Functional & Mathematical Verification Test Suite for the Risk Calculator
...                 Validates factor weights: Proximity to Protected Areas (35%)
Resource            ../resources/pages/risk_calculator_page.robot

Suite Setup         Start Browser Session
Suite Teardown      Close Browser Session
Test Setup          Open Calculator Session and Set Default Options

*** Keywords ***


*** Test Cases ***
PI-6.1: Verify Standalone Proximity to Protected Areas Weighting (Weight: 35%)
    [Tags]             Proximity    Calculation    High
    Set Proximity To Protected Areas                             low
    Verify Proximity To Protected Areas in the Risk Breakdown    0
    
PI-6.2: Verify Standalone Proximity to Protected Areas Weighting (Weight: 35%)
    [Tags]             Proximity    Calculation    High
    Set Proximity To Protected Areas                             medium
    Verify Proximity To Protected Areas in the Risk Breakdown    50
    
PI-6.3: Verify Standalone Proximity to Protected Areas Weighting (Weight: 35%)
    [Tags]             Proximity    Calculation    High
    Set Proximity To Protected Areas                             high
    Verify Proximity To Protected Areas in the Risk Breakdown    100
    

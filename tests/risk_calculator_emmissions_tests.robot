*** Settings ***
Documentation       Functional & Mathematical Verification Test Suite for the Risk Calculator
...                 Validates factor weights: CO2 Emissions (40%)
Resource            ../resources/pages/risk_calculator_page.robot

Suite Setup         Start Browser Session
Suite Teardown      Close Browser Session
Test Setup          Open Calculator Session and Set Default Options

*** Keywords ***


*** Test Cases ***
PI-5.1: Verify Standalone CO2 Emissions Weighting (Weight: 40%)
    [Tags]             Emissions    Calculation    High
    Set CO2 Emissions                             low
    Verify CO2 Emissions in the Risk Breakdown    0

PI-5.2: Verify Standalone CO2 Emissions Weighting (Weight: 40%)
    [Tags]             Emissions    Calculation    High
    Set CO2 Emissions                             medium
    Verify CO2 Emissions in the Risk Breakdown    50

PI-5.3: Verify Standalone CO2 Emissions Weighting (Weight: 40%)
    [Tags]             Emissions    Calculation    High
    Set CO2 Emissions                             high
    Verify CO2 Emissions in the Risk Breakdown    100


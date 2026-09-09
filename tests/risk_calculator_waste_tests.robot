*** Settings ***
Documentation       Functional & Mathematical Verification Test Suite for the Risk Calculator
...                 Validates factor weights: Waste Management (25%)
...                                           -  Recycling Efficiency (30%)
...                                           -  Hazardous Waste Handling (70%)
Resource            ../resources/pages/risk_calculator_page.robot

Suite Setup         Start Browser Session
Suite Teardown      Close Browser Session
Test Setup          Open Calculator Session and Set Default Options

*** Keywords ***
Configure Waste Management And Verify Risk Breakdown
    [Arguments]    ${recyclyng}    ${hazardous}    ${expected_waste_breakdown}
    Set Recycling Efficiency                             ${recyclyng}
    Set Hazardous Waste Handling                         ${hazardous}
    Verify Waste Management in the Risk Breakdown        ${expected_waste_breakdown}

*** Test Cases ***
PI-7.1: Verify inverse risk directionality for Recycling Efficiency sub-factor Weighting (Sub Factor Weight: 30%)
    [Tags]             Waste    Calculation    High
    Set Recycling Efficiency                             low
    Verify Recycling Efficiency in the Risk Breakdown    100
    Verify Waste Management in the Risk Breakdown        0

PI-7.2: Verify inverse risk directionality for Recycling Efficiency sub-factor Weighting (Sub Factor Weight: 30%)
    [Tags]             Waste    Calculation    High
    Set Recycling Efficiency                             medium
    Verify Recycling Efficiency in the Risk Breakdown    50
    Verify Waste Management in the Risk Breakdown        15

PI-7.3: Verify inverse risk directionality for Recycling Efficiency sub-factor Weighting (Sub Factor Weight: 30%)
    [Tags]             Waste    Calculation    High
    Set Recycling Efficiency                             high
    Verify Recycling Efficiency in the Risk Breakdown    0
    Verify Waste Management in the Risk Breakdown        30

PI-8.1: Verify Boolean logic for Hazardous Waste Handling sub-factor Weighting (Sub Factor Weight: 70%)
    [Tags]             Waste    Calculation    High
    Set Recycling Efficiency                             low
    Set Hazardous Waste Handling                         no
    Verify Waste Management in the Risk Breakdown        0

PI-8.2: Verify Boolean logic for Hazardous Waste Handling sub-factor Weighting (Sub Factor Weight: 70%)
    [Tags]             Waste    Calculation    High
    Set Recycling Efficiency                             low
    Set Hazardous Waste Handling                         yes
    Verify Waste Management in the Risk Breakdown        70

PI-9: Verify composite interaction of both Waste Management sub-factors across permutations
    [Tags]             Waste    Calculation    High
    [Template]         Configure Waste Management And Verify Total Risk and Risk Breakdown
#   Recyclyng Efficency    Hazardous Handling    Breakdown Risk - Waste Management
    low                    no                    0
    medium                 no                    15
    high                   no                    30
    low                    yes                   70
    medium                 yes                   85
    high                   yes                   100
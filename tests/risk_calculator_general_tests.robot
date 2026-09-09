*** Settings ***
Documentation       Functional & Mathematical Verification Test Suite for the Risk Calculator
...                 Validates factor weights: . CO2 Emissions (40%)
...                                           . Proximity to Protected Areas (35%)
...                                           . Waste Management (25%)
...                                               -  Recycling Efficiency (30%)
...                                               -  Hazardous Waste Handling (70%)
Resource            ../resources/pages/risk_calculator_page.robot

Suite Setup         Start Browser Session
Suite Teardown      Close Browser Session
Test Setup          Open Calculator Session and Set Default Options

*** Keywords ***
Configure Waste Management And Verify Total Total Environmental Risk
    [Arguments]    ${emmisions}    ${proximity}    ${recyclyng}    ${hazardous}
    Set All Calculator Options    ${emmisions}    ${proximity}    ${recyclyng}    ${hazardous}
    Verify Total Environmental Risk Value
    Validate Total Environmental Risk Level Text


*** Test Cases ***
PI-10.1: Verify absolute theoretical minimum (0.0%) and maximum (100.0%) risk boundary
    [Tags]             General    Calculation    High
    [Template]         Configure Waste Management And Verify Total Total Environmental Risk
#   CO2 EMISSIONS    PROXIMITY TO PROTECTED AREAS    RECYCLING EFFICIENCY    HAZARDOUS WASTE HANDLING
    low              low                             high                    no                          # 0.0%
    high             high                            low                     yes                         # 100.0%

PI-10.2: Verify Total Environmental Risk permutations
    [Tags]             General    Calculation    Low
    [Template]         Configure Waste Management And Verify Total Total Environmental Risk
#   CO2 EMISSIONS    PROXIMITY TO PROTECTED AREAS    RECYCLING EFFICIENCY    HAZARDOUS WASTE HANDLING
    low              low                             high                    yes
    low              low                             medium                  no
    low              low                             medium                  yes
    low              low                             low                     no
    low              low                             low                     yes
    low              medium                          high                    no
    low              medium                          high                    yes
    low              medium                          medium                  no
    low              medium                          medium                  yes
    low              medium                          low                     no
    low              medium                          low                     yes
    low              high                            high                    no
    low              high                            high                    yes
    low              high                            medium                  no
    low              high                            medium                  yes
    low              high                            low                     no
    low              high                            low                     yes
    medium           low                             high                    no
    medium           low                             high                    yes
    medium           low                             medium                  no
    medium           low                             medium                  yes
    medium           low                             low                     no
    medium           low                             low                     yes
    medium           medium                          high                    no
    medium           medium                          high                    yes
    medium           medium                          medium                  no
    medium           medium                          medium                  yes
    medium           medium                          low                     no
    medium           medium                          low                     yes
    medium           high                            high                    no
    medium           high                            high                    yes
    medium           high                            medium                  no
    medium           high                            medium                  yes
    medium           high                            low                     no
    medium           high                            low                     yes
    high             low                             high                    no
    high             low                             high                    yes
    high             low                             medium                  no
    high             low                             medium                  yes
    high             low                             low                     no
    high             low                             low                     yes
    high             medium                          high                    no
    high             medium                          high                    yes
    high             medium                          medium                  no
    high             medium                          medium                  yes
    high             medium                          low                     no
    high             medium                          low                     yes
    high             high                            high                    no
    high             high                            high                    yes
    high             high                            medium                  no
    high             high                            medium                  yes
    high             high                            low                     no

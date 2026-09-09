*** Settings ***
Documentation       Page Object Model for the Environmental Impact Risk Calculator.
Library             SeleniumLibrary
Library             String
Library             ../../libraries/calculations.py
Resource            ../common_keywords.robot
Resource            ./login_page.robot

*** Variables ***
${DASHBOARD_PATH}                          /

# Page Header
${HEADER_PAGE_TITLE}                       xpath://h1[contains(., 'Environmental Impact Risk Calculator')]

# CO2 Emissions Section
${HEADER_CO2_SECTION}                      xpath://h3[normalize-space()='CO₂ Emissions']
${RADIOGROUP_CO2}                          id:emissions
${CO2_SELECTED_BUTTON}                     css:#emissions button[data-state="checked"]
${RADIO_CO2_LOW}                           css:#emissions label:has(button[value="low"])
${RADIO_CO2_MEDIUM}                        css:#emissions label:has(button[value="medium"])
${RADIO_CO2_HIGH}                          css:#emissions label:has(button[value="high"])

# Proximity to Protected Areas Section
${HEADER_PROXIMITY_SECTION}                xpath://h3[normalize-space()='Proximity to Protected Areas']
${RADIOGROUP_PROXIMITY}                    id:proximity
${PROXIMITY_SELECTED_BUTTON}               css:#proximity button[data-state="checked"]
${RADIO_PROXIMITY_LOW}                     css:#proximity label:has(button[value="low"])
${RADIO_PROXIMITY_MEDIUM}                  css:#proximity label:has(button[value="medium"])
${RADIO_PROXIMITY_HIGH}                    css:#proximity label:has(button[value="high"])

# Waste Management Section
${HEADER_WASTE_MANAGEMENT_SECTION}         xpath://h3[normalize-space()='Waste Management']
${CONTAINER_WASTE_MANAGEMENT_SECTION}      xpath://h3[normalize-space()='Waste Management']/ancestor::div[contains(@class, 'glass-card')]

# Recycling Efficiency Section
${LABEL_RECYCLING_SECTION}                 css:label[for="recycling"]
${RADIOGROUP_RECYCLING}                    id:recycling
${RECYCLING_SELECTED_BUTTON}               css:#recycling button[data-state="checked"]
${RADIO_RECYCLING_LOW}                     css:#recycling label:has(button[value="low"])
${RADIO_RECYCLING_MEDIUM}                  css:#recycling label:has(button[value="medium"])
${RADIO_RECYCLING_HIGH}                    css:#recycling label:has(button[value="high"])

# Hazardous Waste Handling Section
${LABEL_HAZARDOUS_SECTION}                 css:label[for="hazardous"]
${CONTAINER_HAZARDOUS_OPTIONS}             css:label[for="hazardous"] ~ div.flex
${HAZARDOUS_SELECTED_TEXT}                 css:div.space-y-3:has(label[for="hazardous"]) label.border-primary span.font-medium
${HAZARDOUS_OPTION_NO}                     css:div.space-y-3:has(label[for="hazardous"]) div.flex > label:first-child
${HAZARDOUS_OPTION_YES}                    css:div.space-y-3:has(label[for="hazardous"]) div.flex > label:last-child

# Total Environmental Risk Section
${HEADER_TOTAL_RISK_SECTION}               xpath://h3[normalize-space()='Total Environmental Risk']
${CARD_TOTAL_RISK}                         xpath://h3[normalize-space()='Total Environmental Risk']/ancestor::div[contains(@class, 'glass-card')]
${TOTAL_RISK_PERCENTAGE}                   css:div.relative span.font-mono.font-bold
${TOTAL_RISK_LEVEL_TEXT}                   css:div.text-center > span.uppercase

# Risk Breakdown Section
${HEADER_RISK_BREAKDOWN_SECTION}           xpath://h3[normalize-space()='Risk Breakdown']
${CONTAINER_RISK_BREAKDOWN}                xpath://h3[normalize-space()='Risk Breakdown']/following-sibling::div[contains(@class, 'space-y-6')]
${BREAKDOWN_VALUE_CO2}                     xpath://span[normalize-space()='CO₂ Emissions']/ancestor::div[contains(@class, 'justify-between')]//span[contains(@class, 'font-mono')][1]
${BREAKDOWN_VALUE_PROXIMITY}               xpath://span[normalize-space()='Proximity to Protected Areas']/ancestor::div[contains(@class, 'justify-between')]//span[contains(@class, 'font-mono')][1]
${BREAKDOWN_VALUE_WASTE}                   xpath://span[normalize-space()='Waste Management']/ancestor::div[contains(@class, 'justify-between')]//span[contains(@class, 'font-mono')][1]
${BREAKDOWN_VALUE_RECYCLING}               xpath://span[normalize-space()='Recycling Efficiency']/ancestor::div[contains(@class, 'justify-between')]//span[contains(@class, 'font-mono')][1]
${BREAKDOWN_VALUE_HAZARDOUS}               xpath://span[normalize-space()='Hazardous Waste Handling']/ancestor::div[contains(@class, 'justify-between')]//span[contains(@class, 'font-mono')][1]

*** Keywords ***
Verify Calculator Page Loaded
    Wait Until Page Contains Element    ${HEADER_PAGE_TITLE}    timeout=10s

# CO2 Emissions
Verify CO2 Emissions Section Exists
    SeleniumLibrary.Page Should Contain Element    ${HEADER_CO2_SECTION}
    SeleniumLibrary.Element Should Be Visible      ${RADIOGROUP_CO2}

Get Selected CO2 Emissions
    ${value}=    SeleniumLibrary.Get Element Attribute    ${CO2_SELECTED_BUTTON}    value
    RETURN    ${value}

Set CO2 Emissions
    [Arguments]    ${value}
    ${value}=    Convert To Lower Case    ${value}
    IF    '${value}' == 'low'
        SeleniumLibrary.Click Element    ${RADIO_CO2_LOW}
    ELSE IF    '${value}' == 'medium'
        SeleniumLibrary.Click Element    ${RADIO_CO2_MEDIUM}
    ELSE IF    '${value}' == 'high'
        SeleniumLibrary.Click Element    ${RADIO_CO2_HIGH}
    ELSE
        Fail    Invalid value for CO2 Emissions: '${value}'. Expected 'low', 'medium', or 'high'.
    END

Get CO2 Emissions Value from the Risk Breakdown
    ${value} =    SeleniumLibrary.Get Text    ${BREAKDOWN_VALUE_CO2}
    RETURN        ${value}

Verify CO2 Emissions in the Risk Breakdown
    [Arguments]    ${expected_value}
    ${breakdown_value} =    Get CO2 Emissions Value from the Risk Breakdown
    TRY
        Should Be Equal As Strings    ${expected_value}%    ${breakdown_value}
    EXCEPT    AS    ${error}
        Fail    Error While checking CO2 Emissions in the Risk Breakdown: ${error}
    END

# Proximity To Protected Areas
Verify Proximity To Protected Areas Section Exists
    SeleniumLibrary.Page Should Contain Element    ${HEADER_PROXIMITY_SECTION}
    SeleniumLibrary.Element Should Be Visible      ${RADIOGROUP_PROXIMITY}

Get Selected Proximity To Protected Areas
    ${value}=    SeleniumLibrary.Get Element Attribute    ${PROXIMITY_SELECTED_BUTTON}    value
    RETURN    ${value}

Set Proximity To Protected Areas
    [Arguments]    ${value}
    ${value}=    Convert To Lower Case    ${value}
    IF    '${value}' == 'low'
        SeleniumLibrary.Click Element    ${RADIO_PROXIMITY_LOW}
    ELSE IF    '${value}' == 'medium'
        SeleniumLibrary.Click Element    ${RADIO_PROXIMITY_MEDIUM}
    ELSE IF    '${value}' == 'high'
        SeleniumLibrary.Click Element    ${RADIO_PROXIMITY_HIGH}
    ELSE
        Fail    Invalid value for Proximity to Protected Areas: '${value}'. Expected 'low', 'medium', or 'high'.
    END

Get Proximity To Protected Areas Value from the Risk Breakdown
    ${value} =    SeleniumLibrary.Get Text    ${BREAKDOWN_VALUE_PROXIMITY}
    RETURN        ${value}

Verify Proximity To Protected Areas in the Risk Breakdown
    [Arguments]    ${expected_value}
    ${breakdown_value} =    Get Proximity To Protected Areas Value from the Risk Breakdown
    TRY
        Should Be Equal As Strings    ${expected_value}%    ${breakdown_value}
    EXCEPT    AS    ${error}
        Fail    Error While checking Proximity To Protected Areas in the Risk Breakdown: ${error}
    END

# Waste Management
Verify Waste Management Section Exists
    SeleniumLibrary.Page Should Contain Element    ${HEADER_WASTE_MANAGEMENT_SECTION}
    SeleniumLibrary.Element Should Be Visible      ${CONTAINER_WASTE_MANAGEMENT_SECTION}

Get Waste Management Value from the Risk Breakdown
    ${value} =    SeleniumLibrary.Get Text    ${BREAKDOWN_VALUE_WASTE}
    RETURN        ${value}

Verify Waste Management in the Risk Breakdown
    [Arguments]    ${expected_value}
    ${breakdown_value} =    Get Waste Management Value from the Risk Breakdown
    TRY
        Should Be Equal As Strings    ${expected_value}%    ${breakdown_value}
    EXCEPT    AS    ${error}
        Fail    Error While checking Waste Management in the Risk Breakdown: ${error}
    END

# Recycling Efficiency
Verify Recycling Efficiency Section Exists
    SeleniumLibrary.Page Should Contain Element    ${LABEL_RECYCLING_SECTION}
    SeleniumLibrary.Element Should Be Visible      ${RADIOGROUP_RECYCLING}

Get Selected Recycling Efficiency
    ${value}=    SeleniumLibrary.Get Element Attribute    ${RECYCLING_SELECTED_BUTTON}    value
    RETURN    ${value}

Set Recycling Efficiency
    [Arguments]    ${value}
    ${value}=    Convert To Lower Case    ${value}
    IF    '${value}' == 'low'
        SeleniumLibrary.Click Element    ${RADIO_RECYCLING_LOW}
    ELSE IF    '${value}' == 'medium'
        SeleniumLibrary.Click Element    ${RADIO_RECYCLING_MEDIUM}
    ELSE IF    '${value}' == 'high'
        SeleniumLibrary.Click Element    ${RADIO_RECYCLING_HIGH}
    ELSE
        Fail    Invalid value for Recycling Efficiency: '${value}'. Expected 'low', 'medium', or 'high'.
    END

Get Recycling Efficiency Value from the Risk Breakdown
    ${value} =    SeleniumLibrary.Get Text    ${BREAKDOWN_VALUE_RECYCLING}
    RETURN        ${value}

Verify Recycling Efficiency in the Risk Breakdown
    [Arguments]    ${expected_value}
    ${breakdown_value} =    Get Recycling Efficiency Value from the Risk Breakdown
    TRY
        Should Be Equal As Strings    ${expected_value}%    ${breakdown_value}
    EXCEPT    AS    ${error}
        Fail    Error While checking Recycling Efficiency in the Risk Breakdown: ${error}
    END

#  Hazardous Waste Handling
Verify Hazardous Waste Handling Section Exists
    SeleniumLibrary.Page Should Contain Element    ${LABEL_HAZARDOUS_SECTION}
    SeleniumLibrary.Element Should Be Visible      ${CONTAINER_HAZARDOUS_OPTIONS}

Get Selected Hazardous Waste Handling
    ${text}=    SeleniumLibrary.Get Text    ${HAZARDOUS_SELECTED_TEXT}
    RETURN    ${text}

Set Hazardous Waste Handling
    [Arguments]    ${value}
    ${value}=    Convert To Lower Case    ${value}
    IF    '${value}' == 'no'
        SeleniumLibrary.Click Element    ${HAZARDOUS_OPTION_NO}
    ELSE IF    '${value}' == 'yes'
        SeleniumLibrary.Click Element    ${HAZARDOUS_OPTION_YES}
    ELSE
        Fail    Invalid value for Hazardous Waste Handling: '${value}'. Expected 'Yes' or 'No'.
    END

# Total Environmental Risk
Verify Total Environmental Risk Section Exists
    SeleniumLibrary.Page Should Contain Element    ${HEADER_TOTAL_RISK_SECTION}
    SeleniumLibrary.Element Should Be Visible      ${CARD_TOTAL_RISK}

Get Total Environmental Risk Percentage
    ${raw_text}=      SeleniumLibrary.Get Text    ${TOTAL_RISK_PERCENTAGE}
    ${percentage}=    Remove String               ${raw_text}    %
    RETURN    ${percentage}

Get Total Environmental Risk Level Text
    ${raw_text}=    SeleniumLibrary.Get Text    ${TOTAL_RISK_LEVEL_TEXT}
    ${clean_text}=  String.Strip String        ${raw_text}
    RETURN          ${clean_text}

Verify Total Environmental Risk Value
    ${section_values}=            Get All Selected Options
    ${expected_percentage}=       calculations.Calculate Total Risk
    ...    emissions=${section_values}[emissions]
    ...    proximity=${section_values}[proximity]
    ...    recycling=${section_values}[recycling]
    ...    hazardous=${section_values}[hazardous]
    ${shown_percentage}=          Get Total Environmental Risk Percentage
    ${shown_percentage}=          Remove String    ${shown_percentage}    %
    TRY
        Should Be Equal As Numbers    ${shown_percentage}    ${expected_percentage}
    EXCEPT    AS    ${error}
        Fail    Error While checking Total Risk Percentage: ${error}
    END

Validate Total Environmental Risk Level Text
    ${percentage}=    Get Total Environmental Risk Percentage
    ${percentage}=    Convert To Number    ${percentage}
    ${actual_level}=  Get Total Environmental Risk Level Text

    IF    ${percentage} < 30
        ${expected_level}=    Set Variable    Low Risk
    ELSE IF    30 <= ${percentage} <= 50
        ${expected_level}=    Set Variable    Moderate Risk
    ELSE
        ${expected_level}=    Set Variable    High Risk
    END

    Should Be Equal As Strings    ${actual_level}    ${expected_level}    ignore_case=True
    ...    msg=Risk level mismatch: Expected '${expected_level}' for ${percentage}%, but found '${actual_level}'.

# Risk Breakdown
Verify Risk Breakdown Section Exists
    SeleniumLibrary.Page Should Contain Element    ${HEADER_RISK_BREAKDOWN_SECTION}
    SeleniumLibrary.Element Should Be Visible      ${CONTAINER_RISK_BREAKDOWN}

Get All Risk Breakdown Values
    ${co2}=          Get CO2 Emissions Value from the Risk Breakdown
    ${proximity}=    Get Proximity To Protected Areas Value from the Risk Breakdown
    ${waste}=        Get Waste Management Value from the Risk Breakdown
    ${recycling}=    Get Recycling Efficiency Value from the Risk Breakdown

    &{breakdown_values}=    Create Dictionary
    ...    emissions=${co2}
    ...    proximity=${proximity}
    ...    waste_management=${waste}
    ...    recycling=${recycling}

    RETURN    &{breakdown_values}

# GENERAL
Get All Selected Options
    ${emissions}=    Get Selected CO2 Emissions
    ${proximity}=    Get Selected Proximity To Protected Areas
    ${recycling}=    Get Selected Recycling Efficiency
    ${hazardous}=    Get Selected Hazardous Waste Handling

    &{selected_options}=    Create Dictionary
    ...    emissions=${emissions}
    ...    proximity=${proximity}
    ...    recycling=${recycling}
    ...    hazardous=${hazardous}

    RETURN    &{selected_options}

Verify All Calculator Sections Exist
    [Documentation]    Verifies the existence and visibility of all four sections.
    Verify CO2 Emissions Section Exists
    Verify Proximity To Protected Areas Section Exists
    Verify Recycling Efficiency Section Exists
    Verify Hazardous Waste Handling Section Exists

Set All Calculator Options
    [Arguments]    ${emissions}    ${proximity}    ${recycling}    ${hazardous}
    Set CO2 Emissions                 ${emissions}
    Set Proximity To Protected Areas  ${proximity}
    Set Recycling Efficiency          ${recycling}
    Set Hazardous Waste Handling      ${hazardous}

Open Calculator Session
    Go To    ${BASE_URL}
    ${on_login}=    Run Keyword And Return Status    Page Should Contain Element    ${INPUT_EMAIL}
    IF    ${on_login}
        login_page.Submit Login Form    ${VALID_EMAIL}    ${VALID_PASSWORD}
    END
    Verify Calculator Page Loaded

Open Calculator Session and Set Default Options
    Open Calculator Session
    Set All Calculator Options    emissions=low    proximity=low    recycling=high    hazardous=no
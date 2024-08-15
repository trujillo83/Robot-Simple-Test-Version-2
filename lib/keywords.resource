*** Settings ***
Documentation       keywords used in get_menu.robot suite
Library             Collections
Library             DateTime
Library             String
Library             SeleniumLibrary
Library             custom_library.py


*** Keywords ***

Initialize Browser For Test
    Get Current Date As Datetime Format
    Open Web Page
    Maximize Browser Window
    Accept Cookies If Asked

Open Web Page
    [Documentation]    open webpage where test will run
    Open Browser    ${HOMEPAGE}    ${BROWSER}
    Maximize Browser Window

Get Current Date As Datetime Format
    [Documentation]    get the current date in computer where running test
    ${current_date}=    Get Current Date
    ${datetime}=    Convert Date    ${current_date}    datetime    exclude_millis=True
    Set Test Variable    ${DATETIME}    ${datetime}

Search In Webpage For Elements In List
    [Documentation]    write and search in webpage with elements found in given list
    [Arguments]    @{list_of_restaurants}
    ${MENUS_LIST}=    Create List
    FOR    ${element_in_list}    IN    @{list_of_restaurants}
        ${day_menu}    Look For Element and Get Text    ${element_in_list}
        Append To List    ${MENUS_LIST}    ${day_menu}
    END
    Set Test Variable    ${MENUS_LIST}
    Set Test Variable    ${RESTAURANTS_LIST}    ${list_of_restaurants}

Create File With Found Menus
    [Documentation]    write in a file the items found in webpage
    [Arguments]    ${file_name_to_write}
    Log Many    @{MENUS_LIST}
    Write To File    ${file_name_to_write}    ${MENUS_LIST}    ${RESTAURANTS_LIST}    ${DATETIME}

Look For Element and Get Text
    [Documentation]    Search in webpage with given element
    [Arguments]    ${search_element}
    Wait Until Page Contains Element    ${ID_BUTTON_OPEN_SEARCH}    timeout=5s
    Click Element    ${ID_BUTTON_OPEN_SEARCH}
    Wait Until Page Contains Element    ${ID_TEXT_INPUT_ELEMENT}    timeout=5s
    Input Text    ${ID_TEXT_INPUT_ELEMENT}    ${search_element}
    Click Element    ${ID_BUTTON_SEARCH}
    ${whole_day_menu}    Get Text    ${ID_TEXT_MENU}

    RETURN    ${whole_day_menu}

Accept Cookies If Asked
    ${status_ok}=    Run Keyword And Return Status
    ...    Wait Until Page Contains Element
    ...    ${ID_BUTTON_COOKIES}
    ...    timeout=2s
    IF    ${status_ok}
        Click Element    ${ID_BUTTON_COOKIES}
    ELSE
        Log To Console    No pop-up window with cookies seen
    END

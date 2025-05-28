*** Settings ***
Documentation       keywords used in get_menu.robot suite
Library             Collections
Library             DateTime
Library             String
Library             SeleniumLibrary
Library             custom_library.py


*** Variables ***
${MAX_RETRIES}    5

*** Keywords ***
Initialize Browser For Test
    Get Current Date As Datetime Format
    Open Web Page
    #Maximize Browser Window
    Set Window Size	    800	    600	    True
    Accept Cookies If Asked
    Close Ad If seen

Close Ad If seen
        ${status_ok}=    Run Keyword And Return Status
    ...    Wait Until Page Contains Element
    ...    ${ID_BUTTON_AD}
    ...    timeout=2s
    IF    ${status_ok}
        Click Element    ${ID_BUTTON_AD}
    ELSE
        Log To Console    No ad seen
    END

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
        ${day_menu}    Retry Keyword Until Success    Look For Element and Get Text    ${element_in_list}
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
    Sleep  2s
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

Retry Keyword Until Success
    [Arguments]    ${keyword}    ${args}
    FOR    ${index}    IN RANGE    ${MAX_RETRIES}
        ${result}    Run Keyword And Ignore Error    ${keyword}    ${args}
        IF  '${result}[0]' == 'PASS'
            RETURN  ${result}[1]
            Exit For Loop
        ELSE IF     ${index}==(${MAX_RETRIES}-1)
            Fail    Keyword '${keyword}' failed after ${MAX_RETRIES} retries.
        ELSE
            ${sleep_time}    Evaluate    1+${index}
            Sleep    ${sleep_time}s
        END
    END

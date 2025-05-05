*** Settings ***
Documentation       check for the menu of the day
Variables           lib/variables.py
Resource            lib/keywords.resource


*** Variables ***
${RESTAURANT_1}    %{RESTAURANT_NAME_1}
${RESTAURANT_2}    %{RESTAURANT_NAME_2}
${RESTAURANT_3}    %{RESTAURANT_NAME_3}
${RESTAURANT_4}    %{RESTAURANT_NAME_4}
${RESTAURANT_5}    %{RESTAURANT_NAME_5}
@{LIST_OF_RESTAURANTS}    ${RESTAURANT_1}    ${RESTAURANT_2}    ${RESTAURANT_3}    ${RESTAURANT_4}    ${RESTAURANT_5}


*** Test Cases ***
Get menu of the day
    [Documentation]    Get menus of the day from your favorite restaurants
    [Setup]    Initialize Browser For Test
    [Teardown]    Close All Browsers
    Search In Webpage For Elements In List    @{LIST_OF_RESTAURANTS}
    Create File With Found Menus    ${PATH_FILE_TO_WRITE}

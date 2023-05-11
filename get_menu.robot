*** Settings ***
Documentation       check for the menu of the day with a robot test cases using python customized libraries

Variables           lib/variables.py
Library             Collections
Library             DateTime
Library             Selenium2Library
Library             lib/custom_library.py
Resource            lib/keywords.resource

Test Setup          Get Current Date As Datetime Format

*** Variables ***
${RESTAURANT_1}    %{RESTAURANT_NAME_1}
${RESTAURANT_2}    %{RESTAURANT_NAME_2}
${RESTAURANT_3}    %{RESTAURANT_NAME_3}
${RESTAURANT_4}    %{RESTAURANT_NAME_4}
@{LIST_OF_RESTAURANTS}    ${RESTAURANT_1}    ${RESTAURANT_2}    ${RESTAURANT_3}    ${RESTAURANT_4}

*** Test Cases ***
Get menus of the day
    [Documentation]    Get menus of the day from your favorite restaurants
    Open Web Page
    Maximize Browser Window
    Search In Webpage For Elements In File    @{LIST_OF_RESTAURANTS}
    Create File With Found Menus    ${PATH_FILE_TO_WRITE}
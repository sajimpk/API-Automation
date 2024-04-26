*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary

*** Variables ***
${BASE_URL}    https://reqres.in/


*** Test Cases ***
POST_Request_API_TESTCASE
    [Tags]    Demo1
    Create Session    mysession1    ${BASE_URL}    disable_warnings=1
    ${endpoint}    Set Variable    /api/users
    ${body}=    Create Dictionary    name=SAJIM    job=Engineer
    ${response}    POST On Session    mysession1    ${endpoint}    data=${body}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}


    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201
    ${jeson_response}=    Convert String To Json    ${response.content}
    ${content}=    Get Value From Json    ${jeson_response}    $.id
    Should Not Be Empty    ${content}    

Get_Request_API_TESTCASE
    [Tags]    Demo2
    Create Session    mysession    ${BASE_URL}    disable_warnings=1
    ${endpoint}    Set Variable    /api/users?page=2
    ${response}    GET On Session    mysession    ${endpoint}
    # Log To Console    ${response.headers}
    Log To Console    ${response.status_code}
    # Log To Console    ${response.content}
    Log               ${response.content}

    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200

PuT_Request_API_TESTCASE
    [Tags]    Demo3
    Create Session    mysession1    ${BASE_URL}    disable_warnings=1
    ${endpoint}    Set Variable    /api/users/2
    ${body}=    Create Dictionary    name=Messi   job=Footbolar
    ${response}    PUT On Session    mysession1    ${endpoint}    data=${body}
    Log To Console    ${response.status_code}
    # Log To Console    ${response.content}


    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200

    ${jeson_response}=    Convert String To Json    ${response.content}
    ${content}=    Get Value From Json    ${jeson_response}    $.updatedAt
    Should Not Be Empty    ${content}    
DELETE_Request_API_TESTCASE
    [Tags]    Demo4
    Create Session    mysession1    ${BASE_URL}    disable_warnings=1
    ${endpoint}    Set Variable    /api/users/2
    ${response}    DELETE On Session    mysession1    ${endpoint}
    Log To Console    ${response.status_code}

    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    204

LOGIN_Request_API_TESTCASE
    [Tags]    Demo5
    Create Session    mysession1    ${BASE_URL}    disable_warnings=1
    ${endpoint}    Set Variable    /api/login
    ${body}=    Create Dictionary    email=eve.holt@reqres.in   password=cityslicka
    ${response}    POST On Session    mysession1    ${endpoint}    data=${body}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${jeson_response}=    Convert String To Json    ${response.content}
    ${content}=    Get Value From Json    ${jeson_response}    $.token
    Should Not Be Empty    ${content}   
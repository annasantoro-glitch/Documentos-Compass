***Settings***
Library    RequestsLibrary
Library    JSONLibrary

***Variables***
${CONFIG_FILE}    ${CURDIR}/config/data.json
${API_BASE_URL}
${USERNAME}
${PASSWORD}
${AUTH_TOKEN}

***Keywords***
Load Configuration
    ${config} =    Load JSON From File    ${CONFIG_FILE}
    Set Suite Variable    ${API_BASE_URL}    ${config}[api_base_url]
    Set Suite Variable    ${USERNAME}        ${config}[auth_credentials][username]
    Set Suite Variable    ${PASSWORD}        ${config}[auth_credentials][password]
    Log To Console        Base URL: ${API_BASE_URL}

Create Session For Booking API
    Create Session    booking_api    ${API_BASE_URL}
    Log To Console    Session 'booking_api' created.

Authenticate User
    ${headers} =    Create Dictionary    Content-Type=application/json
    ${body} =       Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response} =   POST On Session    booking_api    /auth    json=${body}    headers=${headers}
    ${status_code} =    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${json_response} =    To JSON    ${response.text}
    Set Suite Variable    ${AUTH_TOKEN}    ${json_response}[token]
    Log To Console    Authentication successful. Token: ${AUTH_TOKEN}

Create Booking
    [Arguments]    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}
    ${headers} =    Create Dictionary    Content-Type=application/json    Accept=application/json
    ${booking_dates} =    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    ${body} =       Create Dictionary    firstname=${firstname}    lastname=${lastname}    totalprice=${totalprice}    depositpaid=${depositpaid}    bookingdates=${booking_dates}    additionalneeds=${additionalneeds}
    ${response} =   POST On Session    booking_api    /booking    json=${body}    headers=${headers}
    ${status_code} =    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${json_response} =    To JSON    ${response.text}
    Log To Console    Booking created successfully. Booking ID: ${json_response}[bookingid]
    RETURN    ${json_response}[bookingid]

Get Booking By ID
    [Arguments]    ${booking_id}
    ${headers} =    Create Dictionary    Accept=application/json
    ${response} =   GET On Session    booking_api    /booking/${booking_id}    headers=${headers}
    ${status_code} =    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${json_response} =    To JSON    ${response.text}
    Log To Console    Booking details: ${json_response}
    RETURN    ${json_response}

Update Booking
    [Arguments]    ${booking_id}    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}
    ${headers} =    Create Dictionary    Content-Type=application/json    Accept=application/json    Cookie=token=${AUTH_TOKEN}
    ${booking_dates} =    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    ${body} =       Create Dictionary    firstname=${firstname}    lastname=${lastname}    totalprice=${totalprice}    depositpaid=${depositpaid}    bookingdates=${booking_dates}    additionalneeds=${additionalneeds}
    ${response} =   PUT On Session    booking_api    /booking/${booking_id}    json=${body}    headers=${headers}
    ${status_code} =    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${json_response} =    To JSON    ${response.text}
    Log To Console    Booking ${booking_id} updated successfully. Details: ${json_response}

Delete Booking
    [Arguments]    ${booking_id}
    ${headers} =    Create Dictionary    Content-Type=application/json    Cookie=token=${AUTH_TOKEN}
    ${response} =   DELETE On Session    booking_api    /booking/${booking_id}    headers=${headers}
    ${status_code} =    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201    msg=Expected status code 201 for successful deletion
    Log To Console    Booking ${booking_id} deleted successfully.
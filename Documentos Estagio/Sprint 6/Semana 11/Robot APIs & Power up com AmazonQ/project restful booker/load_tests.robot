***Settings***
Resource        resources.robot
Test Setup      Setup Test Environment
Test Teardown   Teardown Test Environment

***Test Cases***
Scenario: Basic Load Test for Creating Bookings
    [Documentation]    Performs basic load test for creating bookings.
    FOR    ${i}    IN RANGE    1    100    # Simula 100 usuários/requisições
        Log To Console    Executing booking creation for iteration ${i}
        Create Booking    John    Doe    150    true    2024-01-01    2024-01-05    Breakfast
    END

Scenario: Basic Load Test for Getting Bookings
    [Documentation]    Performs basic load test for getting bookings.
    ${booking_id} =    Create Booking    Jane    Smith    200    false    2024-02-10    2024-02-15    Dinner    # Cria uma reserva para buscar
    FOR    ${i}    IN RANGE    1    50    # Simula 50 usuários/requisições
        Log To Console    Executing booking retrieval for iteration ${i}
        Get Booking By ID    ${booking_id}
    END
    Delete Booking    ${booking_id}    # Limpa a reserva criada

***Keywords***
Setup Test Environment
    Load Configuration
    Create Session For Booking API
    Authenticate User

Teardown Test Environment
    Log To Console    Test Teardown Complete.
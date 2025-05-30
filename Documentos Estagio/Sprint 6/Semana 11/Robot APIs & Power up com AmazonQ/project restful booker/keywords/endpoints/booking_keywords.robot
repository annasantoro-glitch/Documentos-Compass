*** Settings ***
Documentation     Arquivo com as Keywords específicas para o endpoint de reservas (booking).
Resource          ../common_keywords.robot
Resource          ../endpoints/auth_keywords.robot

*** Keywords ***
# --- Keywords do Endpoint /booking ---
Criar Payload Para Nova Reserva
    [Arguments]    ${firstname}    ${lastname}    ${checkin_date}    ${checkout_date}    ${price}=150    ${deposit}=${TRUE}    ${needs}=Sauna
    ${datas_reserva}=    Create Dictionary    checkin=${checkin_date}    checkout=${checkout_date}
    &{payload_completo}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${price}
    ...    depositpaid=${deposit}
    ...    bookingdates=${datas_reserva}
    ...    additionalneeds=${needs}
    RETURN    ${payload_completo}

Criar Nova Reserva E Retornar ID
    [Arguments]    ${firstname}    ${lastname}    ${checkin_date}    ${checkout_date}
    ${payload}=    Criar Payload Para Nova Reserva    ${firstname}    ${lastname}    ${checkin_date}    ${checkout_date}
    ${resp_post}=    Realizar POST Request    /booking    ${payload}
    Validar Codigo De Resposta    ${resp_post}    200
    ${id_gerado}=    Extrair Valor Do JSON    ${resp_post.json()}    bookingid
    RETURN    ${id_gerado}

Buscar Detalhes Da Reserva Por ID
    [Arguments]    ${id_reserva_para_buscar}
    ${resp_get_id}=    Realizar GET Request    /booking/${id_reserva_para_buscar}
    Validar Codigo De Resposta    ${resp_get_id}    200
    RETURN    ${resp_get_id}

Listar Todas As Reservas
    ${resp_list}=    Realizar GET Request    /booking
    Validar Codigo De Resposta    ${resp_list}    200
    RETURN    ${resp_list}

Buscar Reservas Por Filtro
    [Arguments]    &{params}
    ${resp_filtro}=    Realizar GET Request    /booking    params=${params}
    Validar Codigo De Resposta    ${resp_filtro}    200
    RETURN    ${resp_filtro}

Atualizar Detalhes Da Reserva Completa
    [Arguments]    ${id_para_atualizar}    ${headers}    ${firstname}    ${lastname}    ${checkin}    ${checkout}    ${price}    ${deposit}    ${needs}
    ${datas_atualizacao}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    &{payload_put}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${price}
    ...    depositpaid=${deposit}
    ...    bookingdates=${datas_atualizacao}
    ...    additionalneeds=${needs}
    ${resp_put}=    Realizar PUT Request    /booking/${id_para_atualizar}    ${payload_put}    ${headers}
    Validar Codigo De Resposta    ${resp_put}    200
    RETURN    ${resp_put}

Atualizar Campo Especifico Da Reserva (PATCH)
    [Arguments]    ${id_para_atualizar}    ${headers}    &{payload_patch_data}
    ${resp_patch}=    Realizar PATCH Request    /booking/${id_para_atualizar}    ${payload_patch_data}    ${headers}
    Validar Codigo De Resposta    ${resp_patch}    200
    RETURN    ${resp_patch}

Deletar Reserva Existente
    [Arguments]    ${id_para_deletar}    ${auth_token}
    ${headers}=    Criar Headers Com Token    ${auth_token}
    ${resp_delete}=    Realizar DELETE Request    /booking/${id_para_deletar}    ${headers}
    Validar Codigo De Resposta    ${resp_delete}    201
    RETURN    ${resp_delete}
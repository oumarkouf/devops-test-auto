*** Settings ***
Documentation     Test Automation for Previs TU Environment 
...               Developer : Oumar KOUFERIDJI
Suite Teardown    Close All Browsers
#Test Teardown     Close All Browsers
Library           SeleniumLibrary
Library           DateTime

*** Variables ***
${SERVER}         tuprev02-pfc.dev.echonet:8080
${BROWSER}        %{BROWSER}
${DELAY}          0.5
${VALID USER}     testPF
${VALID PASSWORD}   test
${PREVIS URL}     http://${SERVER}/group/previs
${LOGIN URL}      ${PREVIS URL}/accueil
${RECHERCHE URL}    ${PREVIS URL}/recherche

*** Test Cases ***

Gestion des flux
    Open Browser To Login Page
    Input Username      ${VALID USER}
    Input Password      ${VALID PASSWORD}
    Submit Credentials
    Click on Administration
    Administration
    Capture Page Screenshot        gestionFlux.png

Suivi des Batchs
    Launch Suivi des Batchs
    Capture Page Screenshot        suiviBatch.png

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Accueil - Previs
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Input Username
    [Arguments]    ${username}
    Input Text    _com_liferay_login_web_portlet_LoginPortlet_login   ${username}

Input Password
    [Arguments]    ${password}
    Input Text    _com_liferay_login_web_portlet_LoginPortlet_password    ${password}

Submit Credentials
    Click Button    //form[@id='_com_liferay_login_web_portlet_LoginPortlet_loginForm']/fieldset/div[2]/button

Welcome Page Should Be Open
    Title Should Be  Accueil - Previs

Click on Recherche
    Click Element    layout_11

Click on Administration
    Click Element    layout_7

Administration
    Element Should Not Be Visible   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:j_idt76
    Click Element   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:flowLogicalCode_label
    Click Element   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:flowLogicalCode_2
    #Clicker sur Rechercher
    Click Button    _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:j_idt72
    Wait Until Element Is Visible   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:j_idt76     timeout=8 s
    Click Element   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:policyEventType_label
    Click Element   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:policyEventType_3
    #Clicker sur Rechercher
    Click Button    _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:j_idt72
    Wait Until Element Is Visible   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:j_idt76     timeout=8 s

Launch Suivi des Batchs
    Element Should Not Be Visible   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:j_idt136
    Click Element   _AdministrationPortlet_WAR_previsadministrationPortlet_:j_idt8:j_idt13
    Click Element   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:batchName_label
    Click Element   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:batchName_3
    Click Element   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:j_idt132
    Wait Until Element Is Visible   _AdministrationPortlet_WAR_previsadministrationPortlet_:dynamicPageForm:j_idt136     timeout=8 s
    
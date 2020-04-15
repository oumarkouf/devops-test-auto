*** Settings ***
Documentation     Test Automation for Previs TU Environment 
...               Developer : Oumar KOUFERIDJI
Library           SeleniumLibrary
Library           DateTime
Variables         config.py

*** Variables ***
${SERVER}         tuprev02-pfc.dev.echonet:8080
${BROWSER}        %{BROWSER}
${DELAY}          1
${VALID USER}     testPF
${VALID PASSWORD}   test
${PREVIS URL}     http://${SERVER}/group/previs
${LOGIN URL}      ${PREVIS URL}/accueil
${POLICY RI}      ${P_RI}
${POLICY RD}      ${P_RD}
${POLICY DS}      ${P_DS}

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
    
Type the policyId 
    [Arguments]      ${policy}
    Sleep    1s
    Input Text       input__SearchPortlet_WAR_previssearchPortlet_:tabPanelSearch:form2:policyId   ${policy}
    Title Should Be  Recherche - Previs

Launch Police Recherche     
    Click Button    _SearchPortlet_WAR_previssearchPortlet_:tabPanelSearch:form2:j_idt31

Detail Police   
    [Arguments]      ${police}
    Click Link       ${PREVIS URL}/police?policyId=${police}

Click Resiliation
    Sleep   2s
    Mouse Over      xpath=//*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct:j_idt11"]/ul/li[2]
    Click Element   xpath=//*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct:j_idt11"]/ul/li[2]/ul/li[1]/a
 
Lancer Résiliation Immediate
    Click Element    //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt517:reason"]
    Click Element    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt517:reason_1
    Click Button     _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt517:j_idt537


Input Date
    ${CurrentDate}    Get Current Date
    ${newDate}=       Add Time To Date    ${CurrentDate}    2 days  result_format=%d/%m/%Y
    Execute Javascript           document.getElementById('_AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt517:dateDeffet_input').value ='${newDate}'


Lancer Résiliation Differee
    Click Element     //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt517:reason"]
    Click Element     _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt517:reason_1
    Input Date
    Click Button      _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt517:j_idt537

Resiliation Verifications
    [Arguments]      ${police}      ${type}
    Element Should Contain     //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:messages"]/div/ul/li/span    a été résiliée
    Element Text Should Be     css=.ui-messages-info      La police [${police}] a été résiliée
    #cliquer sur avenants 
    #Sleep   1s
    #Click Element       //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct"]/ul/li[2]
    #Capture Page Screenshot       resiliation-${type}-avenants.png 
    #cliquer sur évenements
    Sleep   1s
    Click Element      //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct"]/ul/li[3]
    Capture Page Screenshot       resiliation-${type}-evenements.png 

Declarer Sinistre
    [Arguments]      ${police}
    Sleep   2s
    Click Element   //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct"]/ul/li[6] 
    Click Button    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct:j_idt463
    Click Button    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:j_idt757
    #choose Guarantee
    Sleep   2s
    Click Element   id=_AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:idGuarant_label
    Click Element   _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:idGuarant_1
    #choose Insurer
    Sleep   2s
    Click Element   //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:idInsurer_label"]
    Click Element   _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:idInsurer_1
    #choose Reason or Motif
    Sleep   2s
    Click Element   _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:idRes_label
    Click Element   _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:idRes_1
    #Enter Adress
    Input Text      _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:idStreet       Rue de Paris
    Input Text      _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:idZipCode      75000
    Input Text      _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:idCity         Paris
    #Validation
    Click Button    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt714:j_idt757
    Element Should Contain     _AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:messages        Un sinistre a été créé
    Element Text Should Be     css=.ui-messages-info        Un sinistre a été créé pour la police [${police}]

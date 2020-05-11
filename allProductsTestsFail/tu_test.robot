*** Settings ***
Documentation     Test Automation for Previs TU Environment (Nonauthorized Action)
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
${RECHERCHE URL}    ${PREVIS URL}/recherche
${Policies}       ${allPolicies}
${PoliciesDS}               ${allPoliciesDS}
${PoliciesTerminated}       ${allPoliciesTerminated}
${PoliciesTDelayed}         ${allPoliciesTD}
#${PoliciesUnpaid}           ${allPoliciesUnpaid}

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
    Click Element   xpath=//*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct:j_idt11"]/ul/li[2]/ul/li[1]

Lancer Annulation Resiliation Differee
    [Arguments]      ${police}
    Sleep   1s
    Click Element   //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct"]/ul/li[3]
    Click Element    css=.ui-button-icon-left
    Click Button    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt936:j_idt943
    Element Text Should Be     css=.ui-messages-info    L'annulation de la résiliation sur la police [${police}] a été effectué
    Element Text Should Be     _PolicySynthesisPortlet_WAR_previspolicySynthesisPortlet_:form1:statePolCustomized      Active
    Element Text Should Be     _PolicySynthesisPortlet_WAR_previspolicySynthesisPortlet_:form1:statutPolCustomized     Normal

Lancer Annulation Impaye
    [Arguments]      ${police}
    Sleep   2s
    Mouse Over      xpath=//*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct:j_idt11"]/ul/li[2]
    Click Element   xpath=//*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct:j_idt11"]/ul/li[2]/ul/li[3]   
    Click Button    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt904:j_idt911
    Element Text Should Be     css=.ui-messages-info    La mise en impayé a été annulée pour la police [${police}]
    Click Element   //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct"]/ul/li[3]
    Element Text Should Be    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct:j_idt205:1:j_idt218    Annulé

Lancer Résiliation Immediate
    Click Element    //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt527:reason_label"]
    Click Element    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt527:reason_1
    Click Button     _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt527:j_idt547

Input Date
    ${CurrentDate}    Get Current Date
    ${newDate}=       Add Time To Date    ${CurrentDate}    2 days  result_format=%d/%m/%Y
    Execute Javascript           document.getElementById('_AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt527:dateDeffet_input').value ='${newDate}'

Lancer Résiliation Differee
    Click Element    //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt527:reason_label"]
    Click Element    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt527:reason_1
    Input Date
    Click Button     _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt527:j_idt547

Lancer Annulation Resiliation
    [Arguments]      ${police}
    Sleep   2s
    Mouse Over      xpath=//*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct:j_idt11"]/ul/li[2]
    Click Element   xpath=//*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct:j_idt11"]/ul/li[2]/ul/li[4]/a
    Click Button    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt924:j_idt931
    Element Text Should Be     css=.ui-messages-info    La résiliation a été annulée pour la police [${police}]


Resiliation Verifications
    [Arguments]      ${police}
    Element Should Contain     //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:messages"]/div/ul/li/span    a été résiliée
    Element Text Should Be     css=.ui-messages-info      La police [${police}] a été résiliée
    #cliquer sur avenants 
    #Sleep   1s
    #Click Element       //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct"]/ul/li[2]
    #Capture Page Screenshot       resiliation-${type}-avenants.png 
    #cliquer sur évenements
    #Sleep   1s
    #Click Element      //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct"]/ul/li[3]
    #Capture Page Screenshot       resiliation-${type}-evenements.png 

Declarer Sinistre
    [Arguments]      ${police}
    Sleep   1s
    Click Element   //*[@id="_AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct"]/ul/li[7] 
    Click Button    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:tabPanelPolicyProduct:j_idt473
    Click Button    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:j_idt767
    #choose Guarantee
    #Sleep   1s
    Click Element   id=_AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:idGuarant_label
    Click Element   _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:idGuarant_1
    #choose Insurer
    #Sleep   1s
    Click Element   _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:idInsurer_label
    Click Element   _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:idInsurer_1
    #choose Reason or Motif
    #Sleep   1s
    Click Element   _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:idRes_label
    Click Element   _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:idRes_1
    #Enter Adress
    Input Text      _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:idStreet       Rue de Paris
    Input Text      _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:idZipCode      75000
    Input Text      _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:idCity         Paris
    #Validation
    Click Button    _AfterSalesPortlet_WAR_previsafterSalesPortlet_:j_idt724:j_idt767
    Element Should Contain     _AfterSalesPortlet_WAR_previsafterSalesPortlet_:form:messages        Un sinistre a été créé
    Element Text Should Be     css=.ui-messages-info        Un sinistre a été créé pour la police [${police}]

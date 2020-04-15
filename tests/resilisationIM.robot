*** Settings ***
Documentation     A test suite with a single test for Resilisation Immediate Policy.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
#Suite Teardown    Close All Browsers
Test Teardown     Close All Browsers
Resource          tu_test.robot

*** Test Cases ***
Resiliation Immediate Police
    Go To       ${LOGIN URL}  
    Click on Recherche
    Type the policyId   ${POLICY RI}
    Launch Police Recherche
    Detail Police       ${POLICY RI}
    Click Resiliation
    Lancer Résiliation Immediate
    Capture Page Screenshot         resiliationIM.png
    Resiliation Verifications       ${POLICY RI}       IM

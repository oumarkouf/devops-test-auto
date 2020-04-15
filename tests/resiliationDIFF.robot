*** Settings ***
Documentation     A test suite with a single test for Resilisation Differee Policy.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
#Suite Teardown    Close All Browsers
#Test Teardown     Close All Browsers
Resource          tu_test.robot

*** Test Cases ***
Resiliation Differee Police
    Go To       ${LOGIN URL}
    #Set Selenium Speed      1
    Click on Recherche
    Type the policyId   ${POLICY RD}
    Launch Police Recherche
    Detail Police       ${POLICY RD}
    Click Resiliation
    Lancer Résiliation Differee
    Capture Page Screenshot         resiliationDI.png
    Resiliation Verifications       ${POLICY RD}      DIFF
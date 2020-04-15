*** Settings ***
Documentation     A test suite with a single test for Sinistre Declaration
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
#Suite Teardown    Close All Browsers
#Test Teardown     Close All Browsers
Resource          tu_test.robot

*** Test Cases ***
Declaration Sinistre
    Open Browser To Login Page
    Input Username      ${VALID USER}
    Input Password      ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open
    Click on Recherche
    Type the policyId   ${POLICY DS}
    Launch Police Recherche
    Detail Police       ${POLICY DS}
    Declarer Sinistre   ${POLICY DS}
    Capture Page Screenshot     declarationSinistre.png
    #Delete All Cookies
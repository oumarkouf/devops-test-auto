*** Settings ***
Documentation     A test suite with a single test for Claim Declaration for All Products.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          tu_test.robot

#*** Variables ***
#@{SUCCESS}      SP  PB  GHOSPI
#without PVQ

*** Test Cases ***
Declaration Sinistre
    Open Browser To Login Page
    Input Username      ${VALID USER}
    Input Password      ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open
    :FOR    ${product}     ${policy}    IN ZIP    ${PoliciesDS.keys()}    ${PoliciesDS.values()}
    \    Go To      ${LOGIN URL}
    \    Click on Recherche
    \    Type the policyId   ${policy}
    \    Launch Police Recherche
    \    Detail Police       ${policy}
    \    Run Keyword And Continue On Failure    Declarer Sinistre   ${policy}
#    \    Run Keyword If    $product in $SUCCESS     Run Keyword And Continue On Failure    Declarer Sinistre   ${policy}
#         ...       ELSE                             Run Keyword And Ignore Error           Declarer Sinistre   ${policy}
#    \    Capture Page Screenshot        declarationSinistre-${policy}.png
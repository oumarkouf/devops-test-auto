*** Settings ***
Documentation     A test suite with a single test for Claim Declaration for All Products.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          tu_test.robot

*** Test Cases ***
Declaration Sinistre
    Open Browser To Login Page
    Input Username      ${VALID USER}
    Input Password      ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open
    Iteration


*** Keywords ***
Iteration
    :FOR    ${product}     ${policy}    IN ZIP    ${Policies.keys()}    ${Policies.values()}
    \    Go To      ${LOGIN URL}
    \    Click on Recherche
    \    Type the policyId   ${policy}
    \    Launch Police Recherche
    \    Detail Police       ${policy}
    \    Run Keyword And Continue On Failure    Declarer Sinistre   ${policy}
    \    Capture Page Screenshot        declarationSinistre-${policy}.png
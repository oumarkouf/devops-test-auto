*** Settings ***
Documentation     A test suite with a single test for Immediate Termination for All Products.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
#Suite Teardown    Close All Browsers
#Test Teardown     Close All Browsers
Resource          tu_test.robot

*** Test Cases ***
Resiliation Immediate All Policies
    :FOR    ${product}     ${policy}    IN ZIP    ${Policies.keys()}    ${Policies.values()}
    \    Go To      ${LOGIN URL}
    \    Click on Recherche
    \    Type the policyId   ${policy}
    \    Launch Police Recherche
    \    Detail Police       ${policy}
    \    Run Keyword And Continue On Failure        Click Resiliation
    \    Run Keyword And Continue On Failure        Lancer Résiliation Immediate
    \    Run Keyword And Continue On Failure        Resiliation Verifications       ${policy}       ${policy}
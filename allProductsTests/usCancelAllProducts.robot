*** Settings ***
Documentation     A test suite with a single test for Resilisation Immediate Policy.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
#Suite Teardown    Close All Browsers
Test Teardown     Close All Browsers
Resource          tu_test.robot

*** Test Cases ***
Annulation Unpaid-Suspended All Policies
    :FOR    ${product}     ${policy}    IN ZIP    ${PoliciesUnpaid.keys()}    ${PoliciesUnpaid.values()}
    \    Go To      ${LOGIN URL}
    \    Click on Recherche
    \    Type the policyId   ${policy}
    \    Launch Police Recherche
    \    Detail Police       ${policy}
    \    Run Keyword And Continue On Failure    Lancer Annulation Impaye    ${policy}
*** Settings ***
Documentation     A test suite with a single test for Cancel Termination for ALL Products
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          tu_test.robot

*** Test Cases ***
Annulation Resiliation All Policies
    :FOR    ${product}     ${policy}    IN ZIP    ${PoliciesTerminated.keys()}    ${PoliciesTerminated.values()}
    \    Go To      ${LOGIN URL}
    \    Click on Recherche
    \    Type the policyId   ${policy}
    \    Launch Police Recherche
    \    Detail Police       ${policy}
    \    Run Keyword And Continue On Failure        Click Annulation Resiliation
    \    Run Keyword And Continue On Failure        Lancer Annulation Resiliation       ${policy}
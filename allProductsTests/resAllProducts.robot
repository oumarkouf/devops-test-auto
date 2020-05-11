*** Settings ***
Documentation     A test suite with a single test for Immediate Termination for All Products.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          tu_test.robot

*** Test Cases ***
Resiliation All Products
    :FOR    ${product}     ${policy}    IN ZIP    ${Policies.keys()}    ${Policies.values()}
    \    Go To      ${RECHERCHE URL}
    \    Type the policyId   ${policy}
    \    Launch Police Recherche
    \    Detail Police       ${policy}
    \    Run Keyword And Continue On Failure     Execute Resiliation    ${policy}
#    \    Run Keyword If    $product in $SUCCESS     Run Keyword And Continue On Failure     Execute Resiliation    ${policy} 
#         ...       ELSE                             Run Keyword And Ignore Error            Execute Resiliation    ${policy}

*** Keywords ***
Execute Resiliation
    [Arguments]      ${police}
    Click Resiliation
    #Lancer Résiliation Immediate
    Lancer Résiliation Differee
    Resiliation Verifications       ${police}
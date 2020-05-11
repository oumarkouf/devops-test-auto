*** Settings ***
Documentation     A test suite with a single test for Cancel Termination for ALL Products
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          tu_test.robot

#*** Variables ***
#@{SUCCESS}      GTM  SP  PVQ  PB  GHOSPI  RNM  ASSIS  CA  ATC  AAC  SAC  TVI  AJ  PVGA

*** Test Cases ***
Annulation Resiliation All Products
    :FOR    ${product}     ${policy}    IN ZIP    ${PoliciesTerminated.keys()}    ${PoliciesTerminated.values()}
    \    Go To      ${RECHERCHE URL}
    \    Type the policyId   ${policy}
    \    Launch Police Recherche
    \    Detail Police       ${policy}
    \    Run Keyword And Continue On Failure        Lancer Annulation Resiliation       ${policy}
#    \    Run Keyword If    $product in $SUCCESS     Run Keyword And Continue On Failure        Lancer Annulation Resiliation       ${policy}
#         ...       ELSE                             Run Keyword And Ignore Error               Lancer Annulation Resiliation       ${policy}

Annulation Resiliation Differee All Products
    :FOR    ${product}     ${policy}    IN ZIP    ${PoliciesTDelayed.keys()}    ${PoliciesTDelayed.values()}
    \    Go To      ${RECHERCHE URL}
    \    Type the policyId   ${policy}
    \    Launch Police Recherche
    \    Detail Police       ${policy}
    \    Run Keyword And Continue On Failure        Lancer Annulation Resiliation Differee      ${policy}
#    \    Run Keyword If    $product in $SUCCESS     Run Keyword And Continue On Failure        Lancer Annulation Resiliation Differee      ${policy}
#         ...       ELSE                             Run Keyword And Ignore Error               Lancer Annulation Resiliation Differee      ${policy}
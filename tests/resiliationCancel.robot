*** Settings ***
Documentation     A test suite with a single test for Cancel Termination for one Product
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          tu_test.robot

*** Test Cases ***
Annulation Resiliation Police
    Go To      ${RECHERCHE URL}
    Type the policyId   ${POLICY AR}
    Launch Police Recherche
    Detail Police       ${POLICY AR}
    Click Annulation Resiliation
    Lancer Annulation Resiliation       ${POLICY AR}
    Capture Page Screenshot         resiliationCancel.png

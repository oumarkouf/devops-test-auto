*** Settings ***
Documentation     A test suite with a single test for Resilisation Differee Policy.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          tu_test.robot

*** Test Cases ***
Resiliation Differee Police
    Go To       ${RECHERCHE URL}
    Type the policyId   ${POLICY RD}
    Launch Police Recherche
    Detail Police       ${POLICY RD}
    Click Resiliation
    Lancer Résiliation Differee
    Capture Page Screenshot         resiliationDI.png
    Resiliation Verifications       ${POLICY RD}      DIFF
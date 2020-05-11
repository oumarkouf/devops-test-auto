<h2> Automated Testing Previs Project (With Robot Framework) </h2>

<h3> All Products Tests </h3>
<a href='https://jenkins.pico-pfc.dev.echonet/job/AP22583-tests-automation-AllProducts/'><img src='https://jenkins.pico-pfc.dev.echonet/job/AP22583-tests-automation-AllProducts/badge/icon'></a>

<h3> Portlet Administration Tests </h3>
<a href='https://jenkins.pico-pfc.dev.echonet/job/AP22583-tests-Portlet-Administration/'><img src='https://jenkins.pico-pfc.dev.echonet/job/AP22583-tests-Portlet-Administration/badge/icon'></a>

Tests .robot are located in folders :

*  allProductsTests
*  test

**INSTALL WEBDRIVER**   `webdrivermanager firefox chrome --linkpath /usr/local/bin`

**LOCAL EXECUTION**    `pipenv run robot -d results tests`

[Robot Framework Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)

[Docker Image for Robot Framework](https://hub.docker.com/r/ppodgorsek/robot-framework)

[Docker Image for Oracle BDD Requests](devpico-pfc.dev.echonet:8083/bnpp-pf/python:1.6)

[Best Practices](https://github.com/robotframework/HowToWriteGoodTestCases/blob/master/HowToWriteGoodTestCases.rst)

[SeleniumLibrary](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)


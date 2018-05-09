*** Settings ***
Library     Selenium2Library
Resource    ../Keyword/GenericKeyword.robot

*** Variables ***
##############       Assign variable in page      #########################
#${LoginForm1}	        xpath=//*[@class='loading-iframe ng-scope']
#${LoginUsername1}        username_CUSTOMER
#${LoginPassword1}	    password_CUSTOMER
#${LoginCheckBox1}	    rememberMe_CUSTOMER
#${LoginResetPassword1}	resetPassword
#${LoginButton1}	        btnLogin
#
#select account_group_id from ac_account where username = '${username}'
#################################################################################

*** Test Cases ***
#Customer is able to access to Customer Profile page
#    [Tags]    DEBUG
#    Open Chrome with  ${D4EScustomer}
#    #Log  ----open browser success----  console=yes
#    Wait Until Page Does Not Contain Element  ${LoginForm1}
#    #Log  \n ----Login form display----  console=yes
#    Select Frame	xpath=//iframe
#    ${pwsshow}=  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${LoginPassword1}  20
#    ${usershow}=  Run Keyword And Ignore Error   Wait Until Page Contains Element  ${LoginUsername1}  20
#    Log  \n ----did you found user >>${usershow}<< and pasword >>${pwsshow}<<----  console=yes
#    Log  \n----Login form display----  console=yes
#    run keyword if    ${usershow}    Enter Text into  ${LoginUsername1}  TEnos@allianz.com
#    run keyword if    ${pwsshow}    Enter Text into  ${LoginPassword1}  Allianz1234
#    Click following button  ${LoginButton1}
#    Log  \n----click login button----  console=yes

#Customer is able to access to Customer Profile page with CSV
#    Open Chrome with  ${D4EScustomer}
#    Load Object and Language  Login
#
#    Wait Until Page Does Not Contain Element  ${LoadingElement}
#    Select Frame	xpath=//iframe
#    ${pwsshow}=  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${LoginPassword}  20
#    ${usershow}=  Run Keyword And Ignore Error   Wait Until Page Contains Element  ${LoginUsername}  20
#    Log  \n ----did you found user >>${usershow}<< and pasword >>${pwsshow}<<----  console=yes
#    Log  \n----Login form display----  console=yes
#
#    run keyword if    ${usershow}    Enter Text into  ${LoginUsername}  TEnos@allianz.com
#    run keyword if    ${pwsshow}    Enter Text into  ${LoginPassword}  Allianz1234
#
#    Click following button  ${LoginButton}
#    Log  \n----click login button----  console=yes


Customer is able to access to Customer Profile page with CSV shoten version
    Open Chrome with  ${D4EScustomer}
    Load Object and Language  Login

    Wait Until Page Does Not Contain Element  ${LoadingElement}
    Select Frame	xpath=//iframe

    Enter Text into  ${LoginUsername["Id"]}  TEnos@allianz.com
    Enter Text into  ${LoginPassword["Id"}}  Allianz1234

    Click following button  ${LoginButton}
#    Log  \n----click login button----  console=yes


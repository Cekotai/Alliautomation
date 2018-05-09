*** Settings ***
Documentation    Suite description
Library  Selenium2Library
Resource  ../Keyword/GenericKeyword.robot

*** Variables ***
##############       Assign variable in page      #########################

${LoginForm}	                xpath=//*[@class='loading-iframe ng-scope']
${LandingCreateAccount}         xpath=//a[@href[contains(.,'create-new-account')]]
${RegistrationForm}	            xpath=//*[@class='loading-iframe ng-hide']
${LandingCreateAccounthref}         xpath=//*[@id="bs-example-navbar-collapse-1"]/ul/li[2]/a

${LoginForm}	        xpath=//*[@class='loading-iframe ng-scope']
${LoginUsername}        username_CUSTOMER
${LoginPassword}	    password_CUSTOMER
${LoginCheckBox}	    rememberMe_CUSTOMER
${LoginResetPassword}	resetPassword
${LoginButton}	        btnLogin

#################################################################################

*** Test Cases ***
Scenario1: Verify that Customer user is able to view Customer Profile Information section
#PASS
	[Tags]	ViewCustomerProfileInfo
####Go to Customer View Profile Information page 	&{viewcustomerprofile001}[txt_email]
    Open Chrome with  ${D4customer}
    Wait Until Page Does Not Contain Element  ${LoginForm}
    Select Frame	xpath=//iframe
    Enter Text into  ${LoginUsername}     TEnos@allianz.com
    Enter Text into  ${LoginPassword}         Allianz1234
    Click following button  ${LoginButton}
    Wait Until Page Does Not Contain Element  xpath=//*[@class='loading-iframe ng-scope']
    Wait Until Element Is Visible  xpath=//*[@prefix-href[contains(.,'#/customer/profile-information-view')]]
	Click Element  xpath=//*[@prefix-href[contains(.,'#/customer/profile-information-view')]]
	Wait Until Page Does Not Contain Element  xpath=//*[@class='loading-iframe ng-scope']
	Wait Until Element Is Visible  //*[@id="ng-app"]/body/div[1]/div[1]/div[1]/h3
    Element Text Should Be  //*[@id="ng-app"]/body/div[1]/div[1]/div[1]/h3    MI PERFIL

	#All Labels are shown correctly

#Scenario2: Verify that Customers Profile information reflects their data correctly
##PASS
#	[Tags]	ViewCustomerProfileInfo
#	[Setup]	Data Setup for View Data
#	Go to Customer View Profile Information page 	&{viewcustomerprofile001}[txt_email]
#	Verify User Information on View Profile Page 	viewData001


*** Keywords ***
Go to Customer View Profile Information page
	[Arguments]	${username}
####Landing.Open Customer Landing Page
	Open Chrome with  ${D4customer}
    #Log  ----open browser success----  console=yes

####Landing.Customer Landing page should be displayed
	Wait Until Page Does Not Contain Element  ${LoginForm}

####Landing.Enter Customer Username		${username}
    Enter Text into  ${LoginUsername}     TEnos@allianz.com

####Landing.Enter Customer Password		${GLOBALPASSWORD}
    Enter Text into  ${LoginPassword}         Allianz1234

####Landing.Click Login Button
	Click following button  ${LoginButton}

####Profile.Customer Profile page should be displayed
	Wait Until Page Does Not Contain Element  xpath=//*[@class='loading-iframe ng-scope']

####Profile.Customer Clicks Profile Information Button
	Wait Until Element Is Visible  xpath=//*[@prefix-href[contains(.,'#/customer/profile-information-view')]]
	Click Element  xpath=//*[@prefix-href[contains(.,'#/customer/profile-information-view')]]

	Profile.Customer Profile Information page should be displayed

Customer Profile page should be displayed
	Common.Loading Icon should not be displayed
	Wait Until Page Does Not Contain Element  xpath=//*[@class='loading-iframe ng-scope']
	Common.Profile Page Title should be appeared 	&{CustomerCommonText}[${language}_pageTitle_profile]

Profile Page Title should be appeared
	[Arguments]	${title}
	${locator}=	Replace String	&{commonField}[profileTitle]	_pageTitle	${title}
	Wait Until Element Is Visible	${locator}

...	profileTitle=xpath=//*[@class='artifex-container']//h1[contains(.,'_pageTitle')]
...	pageTitle=xpath=//div[@class='heading']/h3[contains(text(), '_pageTitle')]
...	pageTitleCus=xpath=//div[@class='heading']/h3[contains(text(), '_pageTitleCus')]
...	pageTitlePro=xpath=//div[@class='heading']/h3[contains(text(), '_pageTitlePro')]
...	pageTitleWR=xpath=//h3[contains(text(), '_pageTitle')]

Customer Clicks Profile Information Button
	Common.Loading Icon should not be displayed
	Common.Scroll Element Into View 	&{dictCustProfile}[btn_viewProfile]
	Wait Until Element Is Visible	&{dictCustProfile}[btn_viewProfile]
	Click Element	&{dictCustProfile}[btn_viewProfile]

Customer Profile Information page should be displayed
	Common.Loading Icon should not be displayed
	Common.Page Title should be appeared 	&{CustomerCommonText}[${language}_pageTitle_profileInfo]
	Common.Page Description should be appeared 	&{CustomerCommonText}[${language}_pageDesc_profileInfoDesc1]
	Common.Page Description should be appeared 	&{CustomerCommonText}[${language}_pageDesc_profileInfoDesc2]

All Labels are shown correctly
	:For 	${labelName}	IN 	@{labelNames}
	\	${lang}	${type}	${element}=	Common.Split data from WordMap 	${labelName}
	\	Run Keyword If	'${lang}' == '${language}' and '${type}' in ['txt','cb']	Common.Text Label should be found	&{CustomerViewProfileInfoText}[${labelName}]
	\	Run Keyword If	'${lang}' == '${language}' and '${type}' == 'btn'	Common.Button Label should be found 	&{CustomerViewProfileInfoText}[${labelName}]	&{dictCustViewProfileInfo}[${type}_${element}]

Verify User Information on View Profile Page
	[Arguments]	${testData}
	:For 	${fieldDetail}	IN 	@{fieldDetails}
	\	${lang}	${type}	${element}=	Common.Split data from WordMap 	${fieldDetail}
	\	Run Keyword If	'${lang}'=='${language}' and '${element}'=='customerID'	Profile.GET Customer Input Data 	&{CustomerViewProfileInfoText}[${fieldDetail}]	${customerID}
	\	Run Keyword If	'${lang}'=='${language}' and '${element}'=='email'	Profile.GET Customer Input Data 	&{CustomerViewProfileInfoText}[${fieldDetail}]	${username}
	\	Run Keyword If 	'${lang}'=='${language}' and not '${element}' in ('customerID','email') and '${type}' in ('txt','ddl') 	Profile.GET Customer Input Data 	&{CustomerViewProfileInfoText}[${fieldDetail}]	&{${testData}}[${type}_${element}]

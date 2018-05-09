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


${RegisterTitle}                title
${RegisterFirstName}            firstName
${RegisterLastname}             lastName
${RegisterPostalCode}           postalCode
${RegisterMobile}               mobile
${RegisterEmail}                email
${RegisterEmailConfirm}         confirmEmail
${RegisterPassword}             artifexPassword
${RegisterPasswordConfirm}      confirmArtifexPassword
${RegisterTermCheckbox}         termsAndConditions
${RegisterCommercialCheckbox}   commercialDisclosures
${RegisterTermLink}             xpath=//*[contains(@oneweb-href,'/conditions-customer')][contains(text(),'Términos y condiciones')]
#link_termsAndConditions=xpath=//*[contains(@oneweb-href,'/conditions-customer')][contains(text(),'Términos y condiciones')]
${RegisterCommercialLink}       xpath=//*[contains(@oneweb-href,'/commercial-disclosure-customer')][contains(text(),'Comunicaciones Comerciales')]
#link_approveDisclosure=xpath=//*[contains(@oneweb-href,'/commercial-disclosure-customer')][contains(text(),'Comunicaciones Comerciales')]
${RegisterCaptchaImage}         imgCaptcha
${RegisterCaptchaAnswer}        captchaAnswer
${RegisterCancelButton}         btnCancel
${RegisterSignupButton}         btnSignup
#...	link_termsAndConditions=xpath=//*[@prefix-href[contains(.,'terms-and-conditions')]]
# ...	link_approveDisclosure=xpath=//*[@prefix-href[contains(.,'Comunicaciones Comerciales')]]
# ...	link_cookies=xpath=//*[contains(@href,'/oneweb/cms/qa-repair4u.es/es/cookies/')][contains(text(),'Cookies')]

${mssqlDbName}      artifex-bs-qa
${mssqlUsername}	artifex-dev2
${mssqlPassword}	artifex-dev2
${mssqlEndpoint}	172.30.155.159
${mssqlPort}        1433
#################################################################################

*** Test Cases ***
Verify that Customer user is able to create account with correct data -PASSED
	[Tags]	Customer 	Registration 	High
#	[Setup]	Data Setup
	###### Go to Customer Registration page ######
	Open Chrome with  ${D4EScustomer}
    Log  ----open browser success----  console=yes
    Unselect Frame
    Wait Until Page Does Not Contain Element  ${LoginForm}
    Log  >>>>> \n We found ${LoginForm} <<<<<<  console=yes

    ${CreateAcctElement}=  Run Keyword And Ignore Error   wait until page contains element  ${LandingCreateAccount}
    ${CreateAcctVisible}=  Run Keyword And Ignore Error   wait until element is visible  ${LandingCreateAccount}
    Log  >>>>> \n Did we find create button element with container? ${CreateAcctElement} \n or ${CreateAcctVisible} <<<<<<  console=yes

    ${CreateAcctElementhref}=  Run Keyword And Ignore Error   wait until page contains element  ${LandingCreateAccounthref}
    ${CreateAcctVisiblehref}=  Run Keyword And Ignore Error   wait until element is visible  ${LandingCreateAccounthref}
    Log  >>>>> \n Did we find create button element eith Xpath? ${CreateAcctElementhref} \n or ${CreateAcctVisiblehref} <<<<<<  console=yes

    run keyword if    ${CreateAcctElement}    Click Element  ${LandingCreateAccounthref}
    run keyword unless    ${CreateAcctElement}    Log  Sure we cannot find this element  console=yes
    Log  >>>>> \n At last we can click and go to Registration page <<<<<<  console=yes
    #Click following button  ${LandingCreateAccount}
	###### Customer Fill in Data on Registration Form	validCust002 	Submit

    wait until page contains element  ${RegistrationForm}

    Log  >>>>> \n Registration is display ${RegistrationForm} <<<<<<  console=yes


############################################### select value from drop down list #######################################################
#    wait until page contains element  ${RegisterTitle}
#    ${options}=  get webelement  ${RegisterTitle}
#    Log  >>>>> \n Value is dropdown list is ${options} <<<<<<  console=yes
##	Select From List    ${RegisterTitle}    Sr
#    click element   xpath=//select[@name='${RegisterTitle}']//option[text()='Sr']
##	select from list by value   ${options}  Sr
#    Select value from dropdown list    ${RegisterTitle}    Sr
#######################################################################################################################################
#    Select Frame	xpath=//iframe
	Enter Text into  ${RegisterFirstName}        Thanatos
	Enter Text into  ${RegisterLastname}         Epnous
	Select value from dropdown list    ${RegisterTitle}    Sr
	Enter Text into  ${RegisterPostalCode}       28000
	Enter Text into  ${RegisterMobile}           081006579
	Enter Text into  ${RegisterEmail}            TEnos@allianz.com
	Enter Text into  ${RegisterEmailConfirm}     TEnos@allianz.com
	Enter Text into  ${RegisterPassword}         Allianz1234
	Enter Text into  ${RegisterPasswordConfirm}  Allianz1234

	Click following Checkbox    ${RegisterTermCheckbox}
#	click element   xpath=//input[@id='${RegisterTermCheckbox}']/following-sibling::span[@class='cr']
	Click following Checkbox    ${RegisterCommercialCheckbox}
#	click element   xpath=//input[@id='${RegisterCommercialCheckbox}']/following-sibling::span[@class='cr']

	Enter Text into   ${RegisterCaptchaAnswer}  artifexcaptcha1234

#	Click following button  ${RegisterCancelButton}
#	Click following button  ${RegisterSignupButton}
#
#    TEnos@allianz.com
#
#    Connect To Database 	pymssql 	${mssqlDbName}	${mssqlUsername}	${mssqlPassword}	${mssqlEndpoint}	${mssqlPort}
#
#    Disconnect From Database
#
#    ${groupID}=	Retrieve Data from DB of Customer  account_group_id 	TEnos@allianz.com
#    ${ExternalID}=	Retrieve Data from DB of Customer  external_user_id 	TEnos@allianz.com
#	Should Match	'${accID}'	'2'
#
#    GET Account Group ID
#	[Arguments]	${username}
#	Connect To Database 	pymssql 	${mssqlDbName}	${mssqlUsername}	${mssqlPassword}	${mssqlEndpoint}	${mssqlPort}
#	${groupID}=	Query 	select account_group_id from ac_account where username = '${username}'
#	[Return]	${groupId[0][0]}
#
#	Customer Profile page should be displayed
#	User should be created in 'Customer' type	&{validCust002}[txt_email]
#	Customer ID should be generated in correct format	&{validCust002}[txt_email]
#	[Teardown]	Cleanup Customer Data	&{validCust002}[txt_email]

Verify that Customer user is able to create account with correct data on new template
    Open Chrome with  ${D4EScustomer}

    Wait Until Page Does Not Contain Element  ${LoginForm}

    ${CreateAcctElement}=  Run Keyword And Ignore Error   wait until page contains element  ${LandingCreateAccount}
    run keyword if    ${CreateAcctElement}    Click Element  ${LandingCreateAccounthref}
    run keyword unless    ${CreateAcctElement}    Log  Sure we cannot find this element  console=yes
    Log  >>>>> \n At last we can click and go to Registration page <<<<<<  console=yes


 #   wait until page contains element  ${RegistrationForm}

    ${CsvFilename}=  get from dictionary  ${ObjectFile}  Register
    Log To Console  ..... Loading Object and Language from ${CsvFilename} .....
#    Assign Objects and Language  ${Language}  ${LanguageColumn}  ${CsvFilename}
    Assign Objects and Language with new temp  ${LANGUAGE}  ${LanguageColumn}  ${CsvFilename}
    Log To Console  ----- Loaded completed -----

    wait until page contains element  ${LoadingElement["Id"]}  ${GLOBALTIMEOUT}

    Get Data by Name    sp_Thantos    SheetName=Registration    FileName=CustomerAccount.xls

    Assign test data to dictionary    ${HeaderValue}    ${ReturnValue}

    Fill Testdata    ${HeaderValue}

*** Keywords ***
Go to Customer Registration page
	Open Customer Landing Page
	Customer Landing page should be displayed
	Open Customer Registration page
	Customer Registration page should be shown

##############################################################################################################
Customer Fill in Data on Registration Form
	[Arguments]	${testData}	${action}
	##FILL IN DATA
	:For 	${fieldName}	IN 	@{fieldNames}
	\	Run Keyword If	'${fieldName}'.startswith('txt_')	Enter Information to field 	&{dictCustRegistration}[${fieldName}]	&{${testData}}[${fieldName}]
	\	Run Keyword If	'${fieldName}'.startswith('ddl_')	Common.Select value in dropdown list 	&{dictCustRegistration}[${fieldName}]	&{${testData}}[${fieldName}]
	\	Run Keyword If	'${fieldName}'.startswith('cb_')	Common.Tick on Agreement checkbox 	&{dictCustRegistration}[${fieldName}]	&{${testData}}[${fieldName}]
	##ACTION BUTTONS
	Run Keyword If	'${action}' == 'Submit'
	...	Run Keywords
	...	CustRegistration.Customer Clicks Submit Button
	...	AND 	CustRegistration.Customer Registration Submitted page should be shown
	...	AND 	CustRegistration.Customer Clicks OK Button
	Run Keyword If	'${action}' == 'Cancel'	Customer Clicks Cancel Button


Select value in dropdown list
	[Arguments]	${elementName}	${_selectOption}
	${locator}=	String.Replace String	&{commonField}[ddlList]	_elementName	${elementName}
	${locator}=	String.Replace String	${locator}	_value	${_selectOption}
	Wait Until Page Contains Element	${locator}
	Scroll Element Into View 	${elementName}
	Click Element	${locator}

Tick on Agreement checkbox
	[Arguments]	${label}	${value}
	##LOCATOR
	${agreement}=	String.Replace String	&{commonField}[agreementField]	_label	${label}
	Scroll Element Into View 	${agreement}
	##CHECK WHETHER IT IS TICKED
	${ticked}=	String.Replace String	&{commonField}[agreementChecked]	_label	${label}
	${checkResult}=	Run Keyword And Return Status	Page Should Contain Element	${ticked}
	Run Keyword If	'${checkResult}'=='True' and '${value}'=='True'
	...	Run Keywords
	...	Wait Until Element Is Visible	${agreement}
	...	AND 	Click Element	${agreement}
	Run Keyword If	'${checkResult}'=='False' and '${value}'=='False'
	...	Run Keywords
	...	Wait Until Element Is Visible	${agreement}
	...	AND 	Click Element	${agreement}

Select value in radio button
	[Arguments]	${elementName}	${value}
	Wait Until Element Is Not Visible 	&{commonField}[loadingIcon]
	${locator}=	String.Replace String	&{commonField}[radioField]	_elementName	${elementName}
	${locator}=	String.Replace String	${locator}	_value	${_value}

	Scroll Element Into View 	${locator}
	Wait Until Element Is Enabled	${locator}	timeout=2
	Click Element	${locator}

##############################################################################################################
Customer Profile page should be displayed
	Wait Until Page Does Not Contain Element	&{commonField}[loadingIcon]
	Profile Page Title should be appeared 	&{CustomerCommonText}[${language}_pageTitle_profile]

Profile Page Title should be appeared
	[Arguments]	${title}
	${locator}=	Replace String	&{commonField}[profileTitle]	_pageTitle	${title}
	Wait Until Element Is Visible	${locator}


User should be created in 'Customer' type
	[Arguments]	${username}
	${accID}=	DBQuery.GET Account Group ID 	${username}
	Should Match	'${accID}'	'2'

Customer ID should be generated in correct format
	[Arguments]	${username}
	${externalID}=	DBQuery.GET Customer External ID 	${username}
	${userType}=	Get Substring	${externalID}	0 	1
	${countryCode}=	Get Substring	${externalID}	1 	3
	${runningNo}=	Get Substring	${externalID}	3 	16
	Should Match	'${userType}'	'C'
	Should Match	'${countryCode}'	'ES'
	${length}=	Get Length 	${runningNo}
	Should Be Equal As Integers	${length}	13

Data Setup
	ExcelLibraryForArtifex.openExcelFile	${customerFilePath}
	ExcelLibraryForArtifex.changeExcelTab	${customerTab}

	${validCust002}=	ExcelLibraryForArtifex.Get Dictionary By Key	${language}_validCustomer002
	Set Suite Variable	${validCust002}

	${fieldNames}=	ExcelLibraryForArtifex.Get First Row List
	Set Suite Variable	${fieldNames}
	${elementFields}=	Collections.Get Dictionary Keys	${dictCustRegistration}
	Set Suite Variable	${elementFields}
	${labelNames}=	Collections.Get Dictionary Keys	${CustRegistrationText}
	Set Suite Variable	${labelNames}


Cleanup Customer Data
	[Arguments]	${username}
	Customer - System Logout 	${username}
	Delete Customer Data By Username 	${username}

Customer - System Logout
	[Arguments]	${username}
	Landing.Open Customer Landing Page
	Landing.Customer Landing page should be displayed
	Landing.Enter Customer Username		${username}
	Landing.Enter Customer Password		${GLOBALPASSWORD}
	Landing.Click Login Button
	Profile.Customer Profile Page should be displayed
	Go To	${customerLogoutURL}

Delete Customer Data By Username
	[Arguments]	${username}
	Connect To Database 	pymssql 	${mssqlDbName}	${mssqlUsername}	${mssqlPassword}	${mssqlEndpoint}	${mssqlPort}
	${cid}=	GET Customer External ID	${username}
	Execute Sql String	delete from cs_customer where external_id = '${cid}';
	Execute Sql String	delete from ac_account where username = '${username}';
	DatabaseLibrary.Check If Not Exists In Database	  select * from ac_account ac inner join cs_customer cs on ac.external_user_id = cs.external_id where ac.username = '${username}';
	Log To Console	Customer Account '${username}' is deleted from database


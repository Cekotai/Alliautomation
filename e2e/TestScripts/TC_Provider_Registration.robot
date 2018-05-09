*** Settings ***
Documentation    Suite description
Library		DatabaseLibrary
Library 	Collections
Library 	String
Library 	Selenium2Library 	run_on_failure=Nothing
Library 	BuiltIn
Library 	Process
Resource    ../Keyword/GenericKeyword.robot
Library         DebugLibrary


#Resource	../Resources/Global.txt
#Resource	../Resources/WebElementMaps.txt
#Resource	../Resources/WordMaps.txt
#Resource	../Resources/Keywords/Landing.txt
#Resource	../Resources/Keywords/Common.txt
#Resource	../Resources/Keywords/Registration.txt
#Resource	../Resources/Keywords/DBQuery.txt
#Resource	../Resources/Keywords/Profile.txt

*** Variables ***
${dataFilePath}	    ../TestData/Test_ProviderAccount.xlsx
${fileUpload}	    ../Resources/library/AutoIT/FileUpload.exe
${basicInfoTab}		BasicInfo
${certificationTab}	CertificationLicense
${serviceTab}		Service
${zoneTab}			Zone
${featureJobTab}	FeatureJob
${bankAccountTab}	BankAccountLegal

*** Test Cases ***
Scenario1: Verify that Provider user is able to create a new account (Basic Information)
#PASS#
#	[Tags]	Provider	Registration	Medium
#	[Template]	Template Create Account Successfully
#	BasicInfoTab 	basicProviderData1	Next

	Open Chrome with  ${D4ESProvider}
#    Load Object and Language  Login

    Wait Until Page Does Not Contain Element  ${LoadingElement}

    ${CsvFilename}=  get from dictionary  ${ObjectFile}  Login
    Log To Console  ..... Loading Object and Language from ${CsvFilename} .....
#    Assign Objects and Language  ${Language}  ${LanguageColumn}  ${CsvFilename}
    Assign Objects and Language with new temp  ${LANGUAGE}  ${LanguageColumn}  ${CsvFilename}
    Log To Console  ----- Loaded completed -----

    Log value of dictionary    ${CreateProviderAccount}

    Click following button    ${CreateProviderAccount["Id"]}

    ${CsvFilename}=  get from dictionary  ${ObjectFile}  Register
    Log To Console  ..... Loading Object and Language from ${CsvFilename} .....
#    Assign Objects and Language  ${Language}  ${LanguageColumn}  ${CsvFilename}
    Assign Objects and Language with new temp  ${LANGUAGE}  ${LanguageColumn}  ${CsvFilename}
    Log To Console  ----- Loaded completed -----

    Wait Until Page Does Not Contain Element  ${LoadingElement}

 #   sleep  10
 #
 #   Select Frame	xpath=//iframe

#    Select Frame	xpath=//iframe
#	${FieldDisplay}=  Run Keyword And Ignore Error  Wait Until Page Contains Element  captchaAnswer  20
#	run keyword if    ${FieldDisplay}  Scroll Element Into View 	captchaAnswer
##	Click Element   ${field}
#    run keyword if    ${FieldDisplay}  Extension Clear Text in field  captchaAnswer
#	run keyword if    ${FieldDisplay}  Input Text	captchaAnswer	artifexcaptcha1234
#	log to console  input value in captch findished
##    Scroll Element Into View    xpath=//a[@class='close-btn']
#    scroll page to top
#    sleep  5
#    ${radioElement}=  Run Keyword And Ignore Error   Page Should Contain Element    xpath=//input[(@name='awpProviderNetwork')]
#    Log  ...... \n Doesn't we found the radio button >>>${radioElement}<<< ......  console=yes

#    ${radioshow}=  Run Keyword And Ignore Error   Element Should Be Visible  xpath=//input[(@name='awpProviderNetwork')and(@value='true')]/following-sibling::span[@class='cr']
#    log to console    did radio button display on screen >>>>${radioshow}
 #   Unselect Frame
 #   Selenium2Library.Execute Javascript    document.body.scrollTop = document.documentElement.scrollTop = 0;
 #   Select Frame	xpath=//iframe
 #
#    Debug
#    run keyword if    ${radioshow}    click element   xpath=//input[(@name='awpProviderNetwork')and(@value='true')]/following-sibling::span[@class='cr']
#    run keyword if    ${radioElement}  Scroll Element Into View    xpath=//div[@class='heading']
#    run keyword if    ${radioElement}  Scroll Element Into View    xpath=//input[(@name='awpProviderNetwork')]
#    run keyword if    ${radioElement}    log to console    Scroll page to see element
#    run keyword if    ${radioElement}   Wait Until Element Is Enabled    xpath=//input[(@name='awpProviderNetwork')and(@value='true')]/following-sibling::span[@class='cr']
#    run keyword if    ${radioElement}    log to console    found element is enable
#    run keyword if    ${radioElement}    click element   xpath=//input[(@name='awpProviderNetwork')and(@value='true')]/following-sibling::span[@class='cr']
#    run keyword if    ${radioElement}    log to console    click element success

    Get Data by Name    sp_basicProvider3    SheetName=BasicInfo    FileName=Test_ProviderAccount.xls
    log to console  Get Header value is ${HeaderValue}
    log to console  Get return value is ${ReturnValue}

    Assign test data to dictionary    ${HeaderValue}    ${ReturnValue}

    Fill Testdata    ${HeaderValue}


*** Keywords ***

Data Setup for Basic Info
	ExcelLibraryForArtifex.openExcelFile	${dataFilePath}
	ExcelLibraryForArtifex.changeExcelTab	${basicInfoTab}

	:For 	${index}	IN RANGE  1  9
	\	${value}= 	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_basicProvider${index}
	\	Set Suite Variable	${basicProviderData${index}}	${value}

	${fieldNames}=	ExcelLibraryForArtifex.Get First Row List
	Set Suite Variable	${fieldNames}

	Go to Provider Create Account Page

Data Setup for Certificate
	ExcelLibraryForArtifex.openExcelFile	${dataFilePath}
	ExcelLibraryForArtifex.changeExcelTab	${certificationTab}

	${certProviderData2}=	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_certProvider2
	${certProviderData7}=	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_certProvider7
	Set Suite Variable	${certProviderData2}
	Set Suite Variable	${certProviderData7}

	${fieldNames}=	ExcelLibraryForArtifex.Get First Row List
	Set Suite Variable	${fieldNames}

Data Setup for Service
	ExcelLibraryForArtifex.openExcelFile	${dataFilePath}
	ExcelLibraryForArtifex.changeExcelTab	${serviceTab}

	${serviceProviderData3}=	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_serviceProvider3
	${serviceProviderData7}=	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_serviceProvider7
	Set Suite Variable	${serviceProviderData3}
	Set Suite Variable	${serviceProviderData7}

	${fieldNames}=	ExcelLibraryForArtifex.Get First Row List
	Set Suite Variable	${fieldNames}

Data Setup for Zone
	ExcelLibraryForArtifex.openExcelFile	${dataFilePath}
	ExcelLibraryForArtifex.changeExcelTab	${zoneTab}

	${zoneProviderData4}=	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_zoneProvider4
	${zoneProviderData7}=	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_zoneProvider7
	Set Suite Variable	${zoneProviderData4}
	Set Suite Variable	${zoneProviderData7}

	${fieldNames}=	ExcelLibraryForArtifex.Get First Row List
	Set Suite Variable	${fieldNames}

Data Setup for Featured Jobs
	ExcelLibraryForArtifex.openExcelFile	${dataFilePath}
	ExcelLibraryForArtifex.changeExcelTab	${featureJobTab}

	${jobsProviderData5}=	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_jobProvider5
	${jobsProviderData7}=	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_jobProvider7
	Set Suite Variable	${jobsProviderData5}
	Set Suite Variable	${jobsProviderData7}

	${fieldNames}=	ExcelLibraryForArtifex.Get First Row List
	Set Suite Variable	${fieldNames}

Data Setup for Bank Account & Legal
	ExcelLibraryForArtifex.openExcelFile	${dataFilePath}
	ExcelLibraryForArtifex.changeExcelTab	${bankAccountTab}

	${bankProviderData6}=	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_bankProvider6
	${bankProviderData7}=	ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_bankProvider7
	Set Suite Variable	${bankProviderData6}
	Set Suite Variable	${bankProviderData7}

	${fieldNames}=	ExcelLibraryForArtifex.Get First Row List
	Set Suite Variable	${fieldNames}

Data Setup for updating Basic Information tab
	ExcelLibraryForArtifex.openExcelFile	${dataFilePath}
	ExcelLibraryForArtifex.changeExcelTab	${basicInfoTab}

	${updatedProviderData1}=		ExcelLibraryForArtifex.Get Dictionary By Key 	${language}_updatedProvider1
	Set Suite Variable	${updatedProviderData1}

	${fieldNames}=	ExcelLibraryForArtifex.Get First Row List
	Set Suite Variable	${fieldNames}

Template Create Account Successfully
	[Arguments]	${tabSection}	${testData}	${action}
	##DATA SETUP
	Run keyword If 	'${tabSection}' == 'BasicInfoTab'	Data Setup for Basic Info
	...	ELSE IF 	'${tabSection}' == 'CertificateTab'	Data Setup for Certificate
	...	ELSE IF 	'${tabSection}' == 'ServicesTab'	Data Setup for Service
	...	ELSE IF 	'${tabSection}' == 'ZonesTab'		Data Setup for Zone
	...	ELSE IF 	'${tabSection}' == 'JobsTab'		Data Setup for Featured Jobs
	...	ELSE IF 	'${tabSection}' == 'BankTab'		Data Setup for Bank Account & Legal
	...	ELSE IF 	'${tabSection}' == 'BasicInfoSubmittedTab'	Data Setup for updating Basic Information tab
	##SELECT TAB
	Run keyword If 	'${tabSection}' == 'BasicInfoTab'	Registration.Click Basic Information Tab
	...	ELSE IF 	'${tabSection}' == 'CertificateTab'	Registration.Click Certifications & Licenses Tab
	...	ELSE IF 	'${tabSection}' == 'ServicesTab'	Registration.Click Services Tab
	...	ELSE IF 	'${tabSection}' == 'ZonesTab'	Registration.Click Zones Tab
	...	ELSE IF 	'${tabSection}' == 'JobsTab'	Registration.Click Featured Jobs Tab
	...	ELSE IF 	'${tabSection}' == 'BankTab'	Registration.Click Bank Account & Legal Tab
	...	ELSE IF 	'${tabSection}' == 'BasicInfoSubmittedTab'	Registration.Click Basic Information Tab
	##FILL IN DATA
	:For 	${fieldName}	IN 	@{fieldNames}
	\	Run Keyword If	'${fieldName}'.startswith('txt_') and '&{${testData}}[${fieldName}]' != '${EMPTY}'	Common.Fill Text Value 	&{dictProviderAccount${tabSection}}[${fieldName}]	&{${testData}}[${fieldName}]
	\	Run Keyword If	'${fieldName}'.startswith('ddl_') and '&{${testData}}[${fieldName}]' != '${EMPTY}'	Common.Select value in dropdown list 	&{dictProviderAccount${tabSection}}[${fieldName}]	&{${testData}}[${fieldName}]
	\	Run Keyword If	'${fieldName}'.startswith('cb_') and '&{${testData}}[${fieldName}]' != '${EMPTY}' and '${tabSection}' == 'BasicInfoTab'	Common.Tick on Agreement checkbox 	&{dictProviderAccount${tabSection}}[${fieldName}]	&{${testData}}[${fieldName}]
	\	Run Keyword If	'${fieldName}'.startswith('cb_') and '&{${testData}}[${fieldName}]' != '${EMPTY}' and '${tabSection}' in ['ServicesTab','ZonesTab']	Common.Tick on Services/Zones checkbox 	&{ProviderAccount${tabSection}}[${language}_${fieldName}]	&{${testData}}[${fieldName}]
	\	Run Keyword If	'${fieldName}'.startswith('rb_') and '&{${testData}}[${fieldName}]' != '${EMPTY}'	Common.Select value in radio button 	&{dictProviderAccount${tabSection}}[${fieldName}]	&{${testData}}[${fieldName}]
	\	Run Keyword If	'${fieldName}'.startswith('opt_') and '&{${testData}}[${fieldName}]' != '${EMPTY}'	Common.Select the Legal Answer 	&{dictProviderAccount${tabSection}}[${fieldName}]	&{${testData}}[${fieldName}]
	\	Run Keyword If	'${fieldName}'.startswith('btn_') and '&{${testData}}[${fieldName}]' != '${EMPTY}'	Select File to upload	&{dictProviderAccount${tabSection}}[${fieldName}]	&{${testData}}[${fieldName}]
	\	Run Keyword If 	'${fieldName}'.startswith('remove_') and '&{${testData}}[${fieldName}]' != '${EMPTY}'	Common.Remove Selected File 	&{dictProviderAccount${tabSection}}[${fieldName}]
	\	Run Keyword If 	'${fieldName}'.startswith('upload_') and '&{${testData}}[${fieldName}]' != '${EMPTY}' and '${tabSection}' in ('CertificateTab','BankTab')	Common.Upload Selected File	&{dictProviderAccount${tabSection}}[${fieldName}]
	\	Run Keyword If 	'${fieldName}'.startswith('upload_') and '&{${testData}}[${fieldName}]' != '${EMPTY}' and '${tabSection}' == 'JobsTab'	Registration.Save Feature Job Image

	Run Keyword If 	'${action}'=='Next'
	...	Run Keywords
	...	Registration.Provider User Clicks Next Button
	...	AND 	Registration.Certifications & Licenses tab should be displayed
	...	AND 	Registration.User should be created in 'Provider' type	&{${testData}}[txt_companyEmail]
	...	AND 	Registration.Provider Profile Status should be "Limited"	&{${testData}}[txt_companyEmail]
	...	AND 	Registration.GET and Verify Provider ID format	&{${testData}}[txt_companyEmail]

	Run Keyword If 	'${action}'=='Submit'
	...	Run Keywords
	...	Registration.Provider User Clicks Done Button
	...	AND 	Registration.Provider Registration Submitted page should be displayed
	...	AND 	Registration.Provider User Clicks OK Button
	...	AND 	Profile.Provider Profile page should be displayed

	Run Keyword If 	'${action}'=='Cancel'
	...	Run Keywords
	...	Registration.Provider User Clicks Cancel Button
	...	AND 	Provider Registration page should not be displayed

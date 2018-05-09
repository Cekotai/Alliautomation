#########################################################################
# Page Object Name : GenericKeyword
# Software : Artifex Spain
# Writer : Pattranit S./ Sareerak C./ Suthinee S.
# Created Date : 08-09-2016
# Modified Date: 27-07-2017
# Dependencies : N/A
# Dependencies : N/A
# Add pageTitlePro for provider title page (Thanarat L.)
#########################################################################

*** Settings ***
Documentation    Suite description
Library         Selenium2Library
Library         Collections
Library         DatabaseLibrary
Library         CSVLibrary
Library			BuiltIn
Library			String
Library	        ExcelLibrary
Library         DebugLibrary


*** Variables ***
${RESOURCE DIR}  ..//Resource//
@{LanguageList}    .br    .es
${CsvCommon}         CommonObject.csv
&{CsvFile}      Common=CommonObject.csv    Login=LoginObject.csv    Profile=ProfileObject.csv
...    Register=Registration.csv

&{ObjectFile}      Common=Common.csv    Login=Login.csv    Profile=Profile.csv
...    Register=Registration.csv

${SERVER}    http://www.google.co.th/
${BROWSER}    firefox
${DELAY}    0
${FF_PROFILE}    C:/Users/thanats/Automation/WebSample/profile
${D4EScustomer}  https://wb-aga-d4.owe2-test.web.allianz/oneweb/cms/qa-repair4u.es/es/
${D4BRcustomer}  https://wb-aga-d4.owe2-test.web.allianz/oneweb/cms/qa-repair4u.br/pt/
${D4ESProvider}  https://wb-aga-d4.owe2-test.web.allianz/oneweb/cms/qa-repair4u.es/es/professional-profile/
${D4BRProvider}  https://wb-aga-d4.owe2-test.web.allianz/oneweb/cms/qa-repair4u.br/pt/professional-profile/

${GLOBALTIMEOUT}	10
${GLOBALRETRYINTERVAL}	6
${GLOBALSELENIUMSPEED}	1
${BROWSER}	Chrome
${CHROMEDRIVERPATH}	${CURDIR}${/}..${/}tools/chromedriver.exe
${DOWNLOADDIRECTORY}	C:/temp/
@{taskkill}	${CURDIR}${/}..${/}}tools/killProcess.bat
${GLOBALPASSWORD}	test1234
${GLOBALCAPTCHA}	artifexcaptcha1234
${GLOBALADMINID}	admin4@allianz.com
${GLOBALADMINPWD}	password
${PAGINGNUMBERS}	10
${euroSign}	€

${mssqlDbName}      artifex-bs-qa
${mssqlUsername}	artifex-dev2
${mssqlPassword}	artifex-dev2
${mssqlEndpoint}	172.30.155.159
${mssqlPort}        1433

${Excel_File_Path}   E:\\Workspace\\Artifex\\TestData\\
*** Keywords ***

#############################################   Open browser keyword   #######################################################
Open Chrome with
    [Arguments]  ${link}
    Open Browser  ${link}  Chrome
    Maximize Browser Window
    Set Selenium Speed  ${DELAY}
    Language Checker time and stamp
    Find Object and Language Column  ${LANGUAGE}
    Load Object and Language Version 0.1  Common


Open IE with
    [Arguments]  ${link}
    ${caps}=    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.INTERNETEXPLORER    sys,selenium.webdriver
    Remove From Dictionary  ${caps}   platform
    Remove From Dictionary  ${caps}   version
    #Set To Dictionary    ${caps}    ignoreProtectedModeSettings    ${True}
    Create WebDriver    Ie    capabilities=${caps}
    Go to    ${link}
    Language Checker time and stamp
    Find Object and Language Column  ${LANGUAGE}
    Load Object and Language  Common
##############################################################################################################################
##################################################   Global keywork   ########################################################
Scroll Element Into View
	[Arguments]	${element}

	${elem}=	Get Webelement	${element}
	${instance}=	Get Library Instance	name=Selenium2Library
	${script}=	Set Variable	arguments[0].scrollIntoView()
	Evaluate	$instance._current_browser().execute_script($script, $elem)

	wait until page contains element	${element}


Scroll page to Top
	Unselect Frame
    Selenium2Library.Execute Javascript    document.body.scrollTop = document.documentElement.scrollTop = 0;
    Select Frame	xpath=//iframe

Input Text With Retry
	[Arguments]	${locator}	${text}
	Selenium2Library.Wait Until Page Contains Element	${locator}
	Wait Until Keyword Succeeds	${GLOBALTIMEOUT}	${GLOBALRETRYINTERVAL}	Input Text And Verify Input	${locator}	${text}

Input Text And Verify Input
	[Arguments]	${locator}	${text}
	Selenium2Library.Click Element	${locator}
	Selenium2Library.Input Text 	${locator}	${text}
	${entered_text}=	Selenium2Library.Get Value	${locator}
	Should Be Equal	'${entered_text}'	'${text}'
	${len}= 	Get Length	${entered_text}
	${len2}= 	Get Length	${text}
	Should Be Equal	${len}	${len2}

Verify page header
    [Arguments]    ${HeaderValue}
    Selenium2Library.Wait Until Page Does Not Contain Element  ${LoadingElement}
    ${HeaderElement2}=  Run Keyword And Ignore Error   Wait Until Element Is Visible    //div[@class='heading']  10
    Log  >>>>> \n Did wait elem visible work, ${HeaderElement2} <<<<<<  console=yes
    ${HeaderElement1}=  Run Keyword And Ignore Error   Selenium2Library.Page Should Contain  ${HeaderValue}
    Log  >>>>> \n Did page contain ${HeaderValue} , ${HeaderElement1} <<<<<<  console=yes
    run keyword if  '${HeaderElement1[0]}'=='FAIL'  Select Frame	xpath=//iframe
    ${HeaderElement1}=  Run Keyword And Ignore Error   Selenium2Library.Page Should Contain  ${HeaderValue}
    Log  >>>>> \n Did page contain ${HeaderValue} , ${HeaderElement1} <<<<<<  console=yes


Log To Console
	[Arguments]  ${text}
		log	${text}\n	console=yes

Log value of dictionary
    [Arguments]    ${variable}
    :FOR    ${key}    IN    @{variable.keys()}
    \   log to console    value of dictionary is >>@{variable}<<
    \   log to console    Assign value of <${key}> is >>${variable["${key}"]}<<

##############################################################################################################################

Click following button
    [Arguments]  ${button}
    Wait Until Page Does Not Contain Element   ${LoadingElement}

    ${ButtonDisplay}=  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${button}  2
#    ${ButtonVisible}=  Run Keyword And Ignore Error  Wait Until Element Is Visible  ${button}  ${GLOBALTIMEOUT}
    run keyword if    '${ButtonDisplay[0]}'=='FAIL'    Select Frame    xpath=//iframe
    run keyword if    '${ButtonDisplay[0]}'=='FAIL'    log to console  .....Select iframe done.....
    ${ButtonDisplay}=  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${button}  2
    log to console    ....Current value of validate given button ${button} is >>>>${ButtonDisplay}
	run keyword if    ${ButtonDisplay}  Scroll Element Into View 	${button}
#	run keyword if    ${ButtonDisplay}  Wait Until Element Is Visible  ${button}
#    run keyword if    ${ButtonDisplay}  Wait Until Element Is Enabled  ${button}
	run keyword if    ${ButtonDisplay}  Click Element  	${button}
	run keyword if    ${ButtonDisplay}  Unselect Frame
	run keyword if    '${ButtonDisplay[0]}'=='FAIL'    Fail  Cannot find provide Button >>>>>>${button}<<<<<<
	run keyword if    '${ButtonDisplay[0]}'=='FAIL'    Unselect Frame


#Enter Information to field
#	[Arguments]	${field}  ${value}
#	Wait Until Page Contains Element 	${field}
#	Input Text With Retry	${field}	${value}

Enter Text into
	[Arguments]	${field}  ${value}
	Wait Until Page Does Not Contain Element  ${LoadingElement}
	log to console    >>>>> Finsih Loading IFrame <<<<<<

    ${fieldDisplay}=  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${field}
    log to console    ....Current value of validate given field ${field} is >>>>${fieldDisplay}
    run keyword if    '${FieldDisplay[0]}'=='FAIL'    Select Frame    xpath=//iframe
    run keyword if    '${FieldDisplay[0]}'=='FAIL'    log to console  .....Select iframe done.....
    ${FieldDisplay}=  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${field}
    log to console    ....Current value of validate given field ${field} is >>>>${fieldDisplay}
	run keyword if    ${FieldDisplay}  Scroll Element Into View 	${field}
	run keyword if    ${FieldDisplay}  log to console    finish scroll to element
    run keyword if    ${FieldDisplay}  Extension Clear Text in field  ${field}
    run keyword if    ${FieldDisplay}  log to console    clear field complete
	run keyword if    ${FieldDisplay}  Input Text	${field}	${value}
	run keyword if    ${FieldDisplay}  Unselect Frame
	run keyword if    '${FieldDisplay[0]}'=='FAIL'    Fail  Cannot find provide Button >>>>>>${field}<<<<<<
	run keyword if    '${FieldDisplay[0]}'=='FAIL'    Unselect Frame

	${entered_text}=	run keyword and ignore error    Selenium2Library.Get Value	${field}
	log to console   value of enter text is >> ${entered_text}
	run keyword if    '${entered_text[0]}'=='FAIL'    Select Frame    xpath=//iframe
	${entered_text}=	run keyword and ignore error    Selenium2Library.Get Value	${field}
	log to console   Now value of enter text is >> ${entered_text}
	${InputInfo}=  run keyword if    ${entered_text}    run keyword and ignore error    Should Be Equal	'${entered_text[1]}'	'${value}'
	log to console   value of compare text is >> ${InputInfo}
	run keyword if    ${entered_text}    Unselect Frame
	run keyword if  '${InputInfo[0]}'=='FAIL'  log to console  >>>>> Input value '''${value}''' not equal with actual value '''${entered_text}''' <<<<<<

#    Select Frame	xpath=//iframe
#	${FieldDisplay}=  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${field}
#	run keyword if    ${FieldDisplay}  Scroll Element Into View 	${field}
#    run keyword if    ${FieldDisplay}  Extension Clear Text in field  ${field}
#	run keyword if    ${FieldDisplay}  Input Text	${field}	${value}
#	run keyword unless    ${FieldDisplay}  Fail  Cannot find provide element >>>>>>${field}<<<<<<
#	${entered_text}=	Selenium2Library.Get Value	${field}
#	${InputInfo}=  run keyword and ignore error  Should Be Equal	'${entered_text}'	'${value}'
#	run keyword unless  ${InputInfo}  Log  >>>>> \nInput value '''${value}''' not equal with actual value '''${entered_text}''' <<<<<<  console=yes
#    Unselect Frame

Extension Clear Text in field
    [Arguments]	${field}
    :FOR    ${index}    IN RANGE    25
    \    Press Key  ${field}  \\8

Click following Checkbox
    [Arguments]	${field}
    Wait Until Page Does Not Contain Element  ${LoadingElement}
    log to console    >>>>> Finsih Loading IFrame <<<<<<

#    Select Frame	xpath=//iframe
#    ${CheckboxExist}=  Run Keyword And Ignore Error   Wait Until Page Contains Element  ${field}  20
#    ${ClickElement}=  Run Keyword And Ignore Error    get webelement  ${field}
#    Log  >>>>> \n Search result of >>>${field}<<< check box value is >>>${CheckboxExist} <<<<<<  console=yes
#    Log  >>>>> \n Search result of >>>${ClickElement}<<< check box value is >>>${CheckboxExist} <<<<<<  console=yes
#	run keyword if    ${CheckboxExist}  click element   xpath=//input[@id='${field}']/following-sibling::span[@class='cr']
#	run keyword unless    ${CheckboxExist}   Log  \n >>>>>>>>>> Cannot find ${field} element, Please Check again <<<<<<<<  console=yes
#	Unselect Frame

	${CheckboxDisplay}=  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${field}  ${GLOBALTIMEOUT}
    run keyword if    '${CheckboxDisplay[0]}'=='FAIL'    Select Frame    xpath=//iframe
    run keyword if    '${CheckboxDisplay[0]}'=='FAIL'    log to console  .....Select iframe done.....
    ${CheckboxDisplay}=  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${field}  ${GLOBALTIMEOUT}
    log to console    ....Current value of validate given field ${field} is >>>>${CheckboxDisplay}
	run keyword if    ${CheckboxDisplay}  click element   xpath=//input[@id='${field}']/following-sibling::span[@class='cr']
#   run keyword if    ${CheckboxDisplay}  Extension Clear Text in field  ${field}
#	run keyword if    ${CheckboxDisplay}  Input Text	${field}	${value}
	run keyword if    ${CheckboxDisplay}  Unselect Frame
	run keyword if    '${CheckboxDisplay[0]}'=='FAIL'    Fail  Cannot find provide Button >>>>>>${field}<<<<<<
	run keyword if    '${CheckboxDisplay[0]}'=='FAIL'    Unselect Frame

Select value from dropdown list
    [Arguments]    ${Field}    ${SelectValue}
    Wait Until Page Does Not Contain Element  ${LoadingElement}
    log to console    >>>>> Finsih Loading IFrame <<<<<<

    sleep  2
    Wait Until Page Does Not Contain Element  ${LoadingElement}
    Select Frame	xpath=//iframe
    ${radioshow}=  Run Keyword And Ignore Error    Element Should Be Visible    xpath=//select[@name='${Field}']
    wait until page contains element  ${Field}    ${globalretryinterval}
    log to console    >>>>> Trying select <<${Field}>> with following value "${SelectValue}"<<<<<< and search result is ${radioshow}
#    ${options1}=  Get Selected List Values  ${Field}
#    ${options2}=  Get Selected List Value  ${Field}
#    ${options3}=  Get Selected List Labels  ${Field}
#    ${options4}=  Get Selected List Label  ${Field}
#    log to console    >>>>>1 Value in dropdown list are ${options1} <<<<<<
#    log to console    >>>>>2 Value in dropdown list are ${options2} <<<<<<
#    log to console    >>>>>3 Value in dropdown list are ${options3} <<<<<<
#    log to console    >>>>>4 Value in dropdown list are ${options4} <<<<<<
#
#    ${ContainValue}=  run keyword and ignore error  should contain    ${options1}    ${SelectValue}
#    run keyword if    '${ContainValue}'=='FAIL'    log to console  .....Dropdown >>${Field}<< doesn't not have >>>>${SelectValue}<<<< value.....
##    run keyword if    '${ContainValue}'=='FAIL'    FAIL    msg=Cannot find value in dropdown field
#    run keyword if    '${ContainValue}'=='PASS'    log to console  .....Found >>${SelectValue}<< in dropdown >>>>${Field}<<<<.....
#    Log  >>>>> Value is dropdown list is ${options1} <<<<<<  console=yes
    #	Select From List    ${RegisterTitle}    Sr
    run keyword if    ${radioshow}    click element   xpath=//select[@name='${Field}']//option[text()='${SelectValue}']
    Unselect Frame

Select value in radio button
    [Arguments]    ${Field}    ${SelectValue}
    Wait Until Page Does Not Contain Element  ${LoadingElement}
#    wait until page contains element  ${Field}    ${globalretryinterval}
    #Scroll Element Into View 	xpath=//input[(@name='${Field}')

    Select Frame	xpath=//iframe
    ${radioElement}=  Run Keyword And Ignore Error   Page Should Contain Element    xpath=//input[(@name='awpProviderNetwork')]
    Log  ...... \n Doesn't we found the radio button >>>${radioElement}<<< ......  console=yes
    scroll page to top
#    run keyword if    ${radioElement}   Scroll Element Into View    //div[@class='heading']
    run keyword if    ${radioElement}  Scroll Element Into View 	xpath=//input[(@name='${Field}')]
    run keyword if    ${radioElement}   Wait Until Element Is Enabled    xpath=//input[(@name='${Field}')and(@value='${SelectValue}')]/following-sibling::span[@class='cr']
    run keyword if    ${radioElement}   Execute JavaScript    window.scrollTo(0, 0)
    run keyword if    ${radioElement}    click element   xpath=//input[(@name='${Field}')and(@value='${SelectValue}')]/following-sibling::span[@class='cr']
    run keyword unless    ${radioElement}    log to console    ...... Sorry we cannot find you desired radio button ......
    Unselect Frame

##############################################################################################################################
#############################################   Import data from excel   #####################################################
Get Data by Name
    [Arguments]  ${Identify}    ${SheetName}=Default    ${FileName}=Default
    ${GivenSheetName}=  set variable    UntouchState
    log to console  Sheet name send from calling function is ${SheetName}
    run keyword if    '${FileName}'=='Default'     Open Excel    ${Excel_File_Path}Test_CustomerAccount.xls
    run keyword if    '${FileName}'!='Default'     Open Excel    ${Excel_File_Path}${FileName}

    run keyword if    '${SheetName}'=='Default'     set test variable    ${GivenSheetName}    None
    run keyword if    '${SheetName}'!='Default'     set test variable    ${GivenSheetName}    Given
 #   Open Excel           ${Excel_File_Path}Test_CustomerAccount.xls
    ${getSheetNames}=      Get Sheet Names
    ${getSheetNum}=        Get Number of Sheets

    run keyword if    '${SheetName}'=='Default'    set test variable    ${SheetName}    ${getSheetNames}
    log to console  Set sheet name is ${SheetName}

    log to console  Wookbook has <<${getSheetNum}>> sheets with following name >>${SheetName}<<

#    ${SheetnameValid}=    run keyword and ignore error    Should Contain    ${getSheetNames}    ${SheetName}
#    run keyword if    '${SheetName}'=='None'  set test variable    ${getSheetNames}   ${SheetName}

    run keyword if    '${GivenSheetName}'=='None'   Extendtion Get Data without Sheet name    ${Identify}    ${SheetName}    ${getSheetNum}
    run keyword if    '${GivenSheetName}'=='Given'   Extendtion Get Data with Sheet name    ${Identify}    ${SheetName}

Extendtion Get Data without Sheet name
    [Arguments]    ${Identify}    ${SheetName}    ${getSheetNum}
    :For 	${index}	IN RANGE  0  ${getSheetNum}
    \   ${CountCol}=        Get Column Count    ${SheetName[${index}]}
	\   ${CountRow}=        Get Row Count       ${SheetName[${index}]}
	\   log to console  Stay on this sheet <<${SheetName[${index}]}>>
	\
    \   Extendtion Loop overroll   ${CountCol}    ${CountRow}    ${Identify}     ${SheetName[${index}]}
    \   ${return}=  should not be empty  ${ReturnValue}
    \   Run Keyword if    '${return}'=='None'    Exit For Loop

Extendtion Get Data with Sheet name
    [Arguments]    ${Identify}    ${SheetName}
    ${CountCol}=        Get Column Count    ${SheetName}
	${CountRow}=        Get Row Count       ${SheetName}
	log to console  Stay on this sheet <<${SheetName}>>

    Extendtion Loop overroll   ${CountCol}    ${CountRow}    ${Identify}     ${SheetName}
    ${return}=  should not be empty  ${ReturnValue}

Extendtion Loop overroll
    [Arguments]  ${Column}    ${Row}    ${Identify}    ${SheetNames}

    :For 	${index}	IN RANGE  1  ${Row}
#    \   ${ColVal}=     Get Column Values    ${SheetNames}  ${index}
    \   ${ColVal}=     Read Cell Data By Name    ${SheetNames}    A${index}
    \   ${RowVal}=     Get Row Values      ${SheetNames}  ${index-1}
    \   log to console  AT loop "${index}" Try to compare <<${ColVal}>> with <<${Identify}>>
    \   ${Comparer}=    run keyword and ignore error    Should Contain  ${ColVal}  ${Identify}
    \   log to console  Result of compare <<${ColVal}>> with <<${Identify}>> is >>>${Comparer}<<<
    \   log to console  Compare value is >>>${Comparer[0]}<<<
    \   Run Keyword if    '${Comparer[0]}' == 'FAIL'    set test variable  ${ReturnValue}  ${EMPTY}
    \   run keyword if    '${Comparer[0]}' == 'PASS'    set test variable  ${ReturnValue}  ${RowVal}
    \   Run Keyword if    '${Comparer[0]}' == 'PASS'    Exit For Loop

    ${HeaderCol}=     Get Row Values      ${SheetNames}  0
    set test variable    ${HeaderValue}    ${HeaderCol}
    [Return]    ${HeaderValue}     ${ReturnValue}

Assign test data to dictionary
    [Arguments]    ${Header}    ${RowValue}
    :For 	${Loopfield}    IN    @{Header}
    \   log to console  Value of field "${Loopfield}" # looping with @{Header}
    \   set test variable    ${Givenkey}    ${Loopfield[0]}
    \   set test variable    ${GivenField}    ${Loopfield[1]}
    \   log to console  value of given key is "${Givenkey}" and value of field is <<${GivenField}>>
    \   Run Keyword If	'${GivenField}'!='key'    log to console  value of Type from given field is >>>${${GivenField}["Type"]}<<<
    \   Run Keyword If	'${GivenField}'!='key'    log to console  value of id from given field is >>>${${GivenField}["Id"]}<<<
    \   Run Keyword If	'${GivenField}'!='key'    log to console  value of value from given field is >>>${${GivenField}["value"]}<<<
    \   Run Keyword If	'${GivenField}'!='key'    Extendtion Loop for value    ${Givenkey}    ${GivenField}    ${RowValue}

Extendtion Loop for value
########### supportive keywork for about ^^^^^^^
    [Arguments]    ${Key}    ${Field}    ${RowValue}
    :For 	${LoopValue}    IN    @{RowValue}
    \   log to console  Value of field "${LoopValue}"
    \   set test variable    ${GivenColumn}    ${LoopValue[0]}
    \   set test variable    ${GivenValue}    ${LoopValue[1]}
    \   log to console  value of given key is "${GivenColumn}" and value of field is <<${GivenValue}>>
    \   ${CompareString}=    Remove String    ${Key}    1
    \   log to console  value of compare string is "${CompareString}"
    \   run keyword if   '${GivenColumn}'.startswith('${CompareString}')    log to console    value from compare is >>>>>${GivenValue}<<<<<
    \   run keyword if   '${GivenColumn}'.startswith('${CompareString}')    Set To Dictionary    ${${Field}}    Testdata    ${GivenValue}
    \   run keyword if   '${GivenColumn}'.startswith('${CompareString}')    Log value of dictionary    ${${Field}}

Fill Testdata
    [Arguments]    ${Header}
    log to console  value of header is ${Header}
    :For 	${Loopfield}    IN    @{HeaderValue}
  #  \   log to console  Value of field "${Loopfield}" # looping with @{HeaderValue}
  #  \   log to console  value of given key is "${Givenkey}" and value of field is <<${GivenField}>>
#    \   set test variable    ${Givenkey}    ${Loopfield[0]}
    \   set test variable    ${GivenField}    ${Loopfield[1]}
    \   log to console  Going to input retrieve information to <<${GivenField}>>
    \   Run Keyword If	'${GivenField}'=='key'  continue for loop
    \   Run Keyword If	'${${GivenField}["Type"]}'=='Text' and '${${GivenField}["Testdata"]}' != '${EMPTY}'      log to console   Input text "${${GivenField}["Testdata"]}" to field <<${${GivenField}["Id"]}>>
    \   Run Keyword If	'${${GivenField}["Type"]}'=='Text' and '${${GivenField}["Testdata"]}' != '${EMPTY}'      Enter Text into  ${${GivenField}["Id"]}  ${${GivenField}["Testdata"]}
    \   Run Keyword If	'${${GivenField}["Type"]}'=='Checkbox' and '${${GivenField}["Testdata"]}' != '${EMPTY}'  log to console   Select following checkbox <<${${GivenField}["Id"]}>>
    \   Run Keyword If	'${${GivenField}["Type"]}'=='Checkbox' and '${${GivenField}["Testdata"]}' != '${EMPTY}'  Click following Checkbox  ${${GivenField}["Id"]}
    \   Run Keyword If	'${${GivenField}["Type"]}'=='Dropdown' and '${${GivenField}["Testdata"]}' != '${EMPTY}'  Log to console  Select this value ${${GivenField}["Testdata"]} from dropdown <<${${GivenField}["Id"]}>>
    \   Run Keyword If	'${${GivenField}["Type"]}'=='Dropdown' and '${${GivenField}["Testdata"]}' != '${EMPTY}'  Select value from dropdown list  ${${GivenField}["Id"]}  ${${GivenField}["Testdata"]}
    \   Run Keyword If	'${${GivenField}["Type"]}'=='Radio' and '${${GivenField}["Testdata"]}' != '${EMPTY}'     Log To Console   select radio with ${${GivenField}["Testdata"]} at radio is as <<${${GivenField}["Id"]}>>
    \   Run Keyword If	'${${GivenField}["Type"]}'=='Radio' and '${${GivenField}["Testdata"]}' != '${EMPTY}'     Select value in radio button  ${${GivenField}["Id"]}  ${${GivenField}["Testdata"]}

#######################################################################################################################################
############################################### Object Management with CSV file #######################################################
#######################################################################################################################################

Load Object and Language Version 0.1
### Keyword
    [Arguments]	${Screen}
    ${CsvFilename}=  get from dictionary  ${CsvFile}  ${Screen}
    Log To Console  ..... Loading Object and Language from ${CsvFilename} .....
#    Assign Objects and Language  ${Language}  ${LanguageColumn}  ${CsvFilename}
    Assign Objects and Language  ${LANGUAGE}  ${LanguageColumn}  ${CsvFilename}
    Log To Console  ----- Loaded completed -----

Load Object and Language
    [Arguments]	${Screen}
    ${CsvFilename}=  get from dictionary  ${ObjectFile}  ${Screen}
    Log To Console  ..... Loading Object and Language from ${CsvFilename} .....
#    Assign Objects and Language  ${Language}  ${LanguageColumn}  ${CsvFilename}
    Assign Objects and Language with new temp  ${LANGUAGE}  ${LanguageColumn}  ${CsvFilename}
    Log To Console  ----- Loaded completed -----

Language Checker time and stamp
#    [Arguments]  ${blank}
    ${URL}=  Get Location

    ${LengthDict}=  get length  ${LanguageList}
#    Log To Console  length of dict file is >>>>>${LengthDict}
#    Log To Console  value of list 0 >>>>> ${LanguageList[0]}
    :For    ${index}    IN RANGE    0    ${LengthDict}
#    \	Log To Console  number of loop >>>>> ${index}
    \   ${Match}=  get regexp matches  ${URL}    (?i)${LanguageList[${index}]}
#    \   Log To Console  value of getmatch >>>>> ${Match} and value of list >>>>> ${LanguageList[${index}]}
    \	${LanguageCheck}=  run keyword and ignore error  Should Contain  ${Match}  ${LanguageList[${index}]}
#    \	Log To Console  language check value is >>>>> ${LanguageCheck}
    \   ${Lang}=  Get Substring  ${LanguageList[${index}]}  -2
    \   run keyword if  '${LanguageCheck[0]}' != 'FAIL'  set test variable  ${LANGUAGE}  ${Lang}
    \	run keyword if  '${LanguageCheck[0]}' != 'FAIL'  Log To Console  >>>>>>>>>> Found ${LANGUAGE} display on browser. <<<<<<<<<<
#    Set Global Variable    ${LANGUAGE}
    [return]  ${LANGUAGE}

File Column Counting
    [Arguments]  ${File}
     @{FileCount}  read csv file to list  ${RESOURCE DIR}${File}

     :FOR    ${INDEX}    IN RANGE    0  20
        \    ${ColumnExist}=  Run Keyword And Ignore Error   Should Not Be Empty  ${FileCount[0][${INDEX}]}
#        \    Log To Console     Result of check next field value is >>>${ColumnExist}<<<
#        \    Log To Console     Value of retrieve column is >>>>>>${FileCount[0][${INDEX}]}<<<<<<<<<
        \    Run Keyword If    '${FileCount[0][${INDEX}]}' != 'null'    Set Test Variable  ${ColumnCount}  ${INDEX+1}
#        \    Log To Console     number of column is >>>${ColumnCount}<<<
        \    ${ColumnExist}=  Run Keyword And Ignore Error   Should Not Be Empty  ${FileCount[0][${INDEX+1}]}
        \    Run Keyword if    '${ColumnExist[0]}' == 'FAIL'    Exit For Loop
      [return]  ${ColumnCount}

Find Object and Language Column
    [Arguments]  ${LANG}
    Log To Console    .......Start mapping language column process.......
    @{FileList}  read csv file to list  ${RESOURCE DIR}${CsvCommon}
    ${ObjectLenght}  File Column Counting  ${RESOURCE DIR}${CsvCommon}

#    Log To Console    .......Column of file is ......${ObjectLenght}.......

    Set Test Variable  ${LanguageColumn}  100

    :FOR    ${INDEX}    IN RANGE    0  ${ObjectLenght}
        \   Continue For Loop If    '${LanguageColumn}' != '100'
#        \    Log To Console     Column value is >>>${FileList[0][${INDEX}]}<<< number of index >>>${index}
        \    Run Keyword If    '${FileList[0][${INDEX}]}' == '${LANG}'    Set Test Variable  ${LanguageColumn}  ${INDEX}
#        \    Log To Console     LanguageColumn is >>>${LanguageColumn}<<<
        \    ${ColumnExist}=  Run Keyword And Ignore Error   Should Not Be Empty  ${FileList[0][${INDEX+1}]}
        \    Run Keyword if    '${ColumnExist[0]}' == 'FAIL'    Exit For Loop
#        \    Run Keyword If    '${FileList[0][${INDEX+1}]}' == 'null'    Exit For Loop

    Run Keyword If    '${LanguageColumn}' == '100'    Log To Console    Input language ${LANG} cannot found
    Log To Console    ---Mapping column done found Language column is ${LanguageColumn}---

Assign Objects and Language
    [Arguments]  ${LANGUAGE}  ${LANGUAGECOLUMN}  ${FILENAME}
#    Log To Console  language column is ${LANGUAGECOLUMN}
	@{ObjectMapping}=  read csv file to list  ${RESOURCE DIR}${FILENAME}
	${length_dict}= 	Get Length  ${ObjectMapping}
#	Log To Console   ...... length of file is ${length_dict} ......
	:For    ${loop}  IN RANGE  1  ${length_dict}
#  	    \   Log To Console   Number of loop is ${loop}
#  	    \   Log To Console   Condition value is ${ObjectMapping[${loop}][0]}
#  	    \   Log To Console   Object name is ${ObjectMapping[${loop}][1]}
#  	    \   Log To Console   Object value is ${ObjectMapping[${loop}][2]}
#  	    \   Log To Console   Text value is ${ObjectMapping[${loop}][${LANGUAGECOLUMN}]}
	    \   Run Keyword If    '${ObjectMapping[${loop}][0]}' == 'Object'  Set Test Variable  ${${ObjectMapping[${loop}][1]}}  ${ObjectMapping[${loop}][2]}
#	    \   Run Keyword If    '${ObjectMapping[${loop}][1]}' == 'Object'  Log To Console  Object value of >>>${${ObjectMapping[${loop}][1]}}<<< is >>>${${ObjectMapping[${loop}][2]}}<<<
	    \   Run Keyword If    '${ObjectMapping[${loop}][0]}' == 'Text'  Set Test Variable  ${${ObjectMapping[${loop}][1]}}  ${ObjectMapping[${loop}][${LANGUAGECOLUMN}]}
#	    \   Run Keyword If    '${ObjectMapping[${loop}][1]}' == 'Text'  Log To Console  Text value of >>>${${ObjectMapping[${loop}][1]}}<<< is >>>${ObjectMapping[${loop}][${LANGUAGECOLUMN}]}<<<

    Set Global Variable    ${LANGUAGE}
	Set Global Variable    ${LANGUAGECOLUMN}


Assign Objects and Language with new temp
    [Arguments]  ${LANGUAGE}  ${LANGUAGECOLUMN}  ${FILENAME}
#    Log To Console  language column is ${LANGUAGECOLUMN}
	@{ObjectMapping}=  read csv file to list  ${RESOURCE DIR}${FILENAME}
	${length_dict}= 	Get Length  ${ObjectMapping}
#	Log To Console   ...... length of file is ${length_dict} ......

	:For    ${loop}  IN RANGE  1  ${length_dict}
	    \   Log To Console   Number of loop is ${loop}
        \   Log To Console   Value of field '0' is ${ObjectMapping[${loop}][0]}
        \   Log To Console   Value of field '1' is ${ObjectMapping[${loop}][1]}
        \   Log To Console   Value of field '2' is ${ObjectMapping[${loop}][2]}
        \   Log To Console   Value of field '3' is ${ObjectMapping[${loop}][${LANGUAGECOLUMN}]}
	    \   ${tempDict}=  create dictionary    Type=${ObjectMapping[${loop}][0]}   Id=${ObjectMapping[${loop}][2]}    value=${ObjectMapping[${loop}][${LANGUAGECOLUMN}]}
	    \   set test variable  ${${ObjectMapping[${loop}][1]}}  ${tempDict}
#  	    \   Run Keyword If    '${ObjectMapping[${loop}][3]}' == 'Object'
#  	    \   Log To Console   Condition value is ${ObjectMapping[${loop}][0]}
#  	    \   Log To Console   Object name is ${ObjectMapping[${loop}][1]}
#  	    \   Log To Console   Object value is ${ObjectMapping[${loop}][2]}
#  	    \   Log To Console   Text value is ${ObjectMapping[${loop}][${LANGUAGECOLUMN}]}
#	    \   Run Keyword If    '${ObjectMapping[${loop}][0]}' == 'Object'  Set Test Variable  ${${ObjectMapping[${loop}][1]}}  ${ObjectMapping[${loop}][2]}
#	    \   Run Keyword If    '${ObjectMapping[${loop}][1]}' == 'Object'  Log To Console  Object value of >>>${${ObjectMapping[${loop}][1]}}<<< is >>>${${ObjectMapping[${loop}][2]}}<<<
#	    \   Run Keyword If    '${ObjectMapping[${loop}][0]}' != 'Object'  Set Test Variable  ${${ObjectMapping[${loop}][1]}}  ${ObjectMapping[${loop}][${LANGUAGECOLUMN}]}
#	    \   ${${ObjectMapping[${loop}][1]}}=  Run Keyword If    '${ObjectMapping[${loop}][1]}' != 'Object'    create dictionary    Type=${${ObjectMapping[${loop}][0]}}    Id=${${ObjectMapping[${loop}][2]}}
    Set Global Variable    ${LANGUAGE}
	Set Global Variable    ${LANGUAGECOLUMN}

#######################################################################################################################################
##################################################  Database management keyword  ######################################################

Retrieve Data from DB of Customer
	[Arguments]  ${field}  ${valuecondition}
	Connect To Database 	pymssql 	${mssqlDbName}	${mssqlUsername}	${mssqlPassword}	${mssqlEndpoint}	${mssqlPort}
	${customerExtID}=	Query 	select ${field} from ac_account where username = '${valuecondition}'
	[Return]	${customerExtID[0][0]}

Delete Customer Data By Username
	[Arguments]	${username}
	Connect To Database 	pymssql 	${mssqlDbName}	${mssqlUsername}	${mssqlPassword}	${mssqlEndpoint}	${mssqlPort}
	${cid}=	GET Customer External ID	${username}
	Execute Sql String	delete from cs_customer where external_id = '${cid}';
	Execute Sql String	delete from ac_account where username = '${username}';
	DatabaseLibrary.Check If Not Exists In Database	  select * from ac_account ac inner join cs_customer cs on ac.external_user_id = cs.external_id where ac.username = '${username}';
	Log To Console	Customer Account '${username}' is deleted from database

Delete Provider Data By Username
	[Arguments]	${username}
	Connect To Database 	pymssql 	${mssqlDbName}	${mssqlUsername}	${mssqlPassword}	${mssqlEndpoint}	${mssqlPort}
	${id}=	GET External ID 	${username}
	${pid}=	GET Provider ID 	${username}
	Execute Sql String	delete from ac_account where external_id = '${id}';
	Execute Sql String	delete from pv_person where provider_id = '${pid}';
	Execute Sql String	delete from pv_provider_question_answer where provider_id = '${pid}';
	Execute Sql String	delete from pv_provider_review where provider_id = '${pid}';
	Execute Sql String	delete from pv_provider where company_email = '${username}';
	DatabaseLibrary.Check If Not Exists In Database	select * from ac_account AC JOIN pv_provider PV on AC.external_user_id=PV.external_id where AC.username = '${username}';
	Log To Console	Provider Account '${username}' is deleted from database

Delete Provider Change Status By Username
	[Arguments]	${username}
	Connect To Database 	pymssql 	${mssqlDbName}	${mssqlUsername}	${mssqlPassword}	${mssqlEndpoint}	${mssqlPort}
	${pid}=	GET Provider ID 	${username}
	${numberOfLog}=	GET Number of Status Change ID 	${pid}
	${statusChangeID}=	GET Provider Status Change ID 	${pid}
	:FOR  ${index}  IN RANGE  0  ${numberOfLog}
	\	${recordID}=	Set Variable 	${statusChangeID[${index}][0]}
	\	Execute Sql String	delete from pv_admin_operate_provider_data where admin_operate_provider_id = ${recordID}
	Execute Sql String	delete from pv_admin_operate_provider where provider_id = ${pid}

GET Provider Status Change ID
	[Arguments]	${providerID}
	Connect To Database 	pymssql 	${mssqlDbName}	${mssqlUsername}	${mssqlPassword}	${mssqlEndpoint}	${mssqlPort}
	${statusID}=	Query 	select admin_operate_provider_id from pv_admin_operate_provider_data plog inner join pv_admin_operate_provider pdata on plog.admin_operate_provider_id = pdata.id where pdata.provider_id = ${providerID}
	[Return]	${statusID}

GET Number of Status Change ID
	[Arguments]	${providerID}
	Connect To Database 	pymssql 	${mssqlDbName}	${mssqlUsername}	${mssqlPassword}	${mssqlEndpoint}	${mssqlPort}
	${numberOfLog}=	Query 	select count (*) from pv_admin_operate_provider_data plog inner join pv_admin_operate_provider pdata on plog.admin_operate_provider_id = pdata.id where pdata.provider_id = ${providerID}
	[Return]	${numberOfLog[0][0]}

Delete Provider SINTRA Log By Username
	[Arguments]	${username}
	Connect To Database 	pymssql 	${mssqlDbName}	${mssqlUsername}	${mssqlPassword}	${mssqlEndpoint}	${mssqlPort}
	${pid}=	GET Provider ID 	${username}
	${numberOfLog}=	GET Number of Provider SINTRA Log 	${pid}
	${logID}=	GET Provider SINTRA Log 	${pid}
	:FOR  ${index}  IN RANGE  0  ${numberOfLog}
	\	${recordID}=	Set Variable 	${logID[${index}][0]}
	\	Execute Sql String 	delete from pv_sintra_log_data where entry_log_id = ${recordID}
	Execute Sql String 	delete from pv_sintra_log_entry where provider_id = ${pid}
#######################################################################################################################################


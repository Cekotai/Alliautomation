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

*** Test Cases ***
Test title


    Open Chrome with  ${D4EScustomer}
    Load Object and Language Version 0.1  Login

    Wait Until Page Does Not Contain Element  ${LoadingElement}
#    Select Frame	xpath=//iframe

    Enter Text into  username_CUSTOMER  prashant.rajoria@allianz.com
    Enter Text into  password_CUSTOMER  password
#    Debug
    Click following button  ${LoginButton}

    Load Object and Language  Profile

    Verify page header   DEL CLIENTE
#    Wait Until Page Does Not Contain Element  ${LoadingElement}
#    ${HeaderElement1}=  Run Keyword And Ignore Error   Page Should Contain  DEL CLIENTE
#    Log  >>>>> \n Page Should Contain //div[@class='heading'], ${HeaderElement1} <<<<<<  console=yes
    debug
    Click following button  ${ProfileFixPackage["Id"]}
#    debug
    Wait Until Page Does Not Contain Element  ${LoadingElement}
    Verify page header  My Purchased Fixed Price Package

    Debug
    Click following button

    #FPESB2C12382
    #  //tr[@data-target='#FPESB2C12382']/td[1]

*** Keywords ***
Provided precondition
    Setup system under test
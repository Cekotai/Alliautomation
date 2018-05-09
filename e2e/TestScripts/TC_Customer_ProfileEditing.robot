*** Settings ***
Library     Selenium2Library
Resource    ../Keyword/GenericKeyword.robot

*** Variables ***
##############       Assign variable in page      #########################

${LoginForm}	                    xpath=//*[@class='loading-iframe ng-scope']
${LoadingElement}	                xpath=//*[@class='loading-iframe ng-scope']
${LandingCreateAccount}             xpath=//a[@href[contains(.,'create-new-account')]]
${RegistrationForm}	                xpath=//*[@class='loading-iframe ng-hide']
${LandingCreateAccounthref}         xpath=//*[@id="bs-example-navbar-collapse-1"]/ul/li[2]/a

${LoginForm}	        xpath=//*[@class='loading-iframe ng-scope']
${LoginUsername}        username_CUSTOMER
${LoginPassword}	    password_CUSTOMER
${LoginCheckBox}	    rememberMe_CUSTOMER
${LoginResetPassword}	resetPassword
${LoginButton}	        btnLogin


${ProfileEdit}      btnEdit
${ProfileReset}     btnForgot
${ProfileSubmit}    btnModify
${ProfileCancel}    btnCancel
${ViewMyProfile}    xpath=//*[@prefix-href[contains(.,'#/customer/profile-information-view')]]

${MyProfileTitle}                title
${MyProfileFirstName}            firstName
${MyProfileLastname}             lastName
${MyProfilePostalCode}           postalCode
${MyProfileMobile}               mobile
${MyProfileDisclosure}           xpath=//*[contains(@oneweb-href,'/commercial-disclosure-customer')][contains(text(),'Comunicaciones Comerciales')]
${customerlandingURL}            https://wb-aga-d4.owe2-test.web.allianz/oneweb/cms/qa-repair4u.es/es/
${MyProfileHeader}               xpath=//*[@id="ng-app"]/body/div[1]/div[1]/div[1]/h3

${MyProfileCancelPopupYes}       xpath=//button[@ng-click='vm.ok()']
${MyProfileCancelPopupNo}        xpath=//button[@ng-click='vm.cancel()']

errorValidate=xpath=//div[(@role="alert") and contains(.,'_error')]
#...errorValidate=xpath=//*[contains(.,'*')]//*[@name='_field']/following-sibling::*[contains(.,'_error')]

backendValidate=//*[@ng-click='tapToast()']//*[.='_error']
#...	backendValidate=//*[@id='toast-container'] and and contains(.,'_error')]
mandatory=//div[(@role="alert") and contains(. ,'_error')]

popupLabel=xpath=//div[@class='modal-content']//*[.='_label']
     en_desc_cancel=Are you sure you want to cancel your changes?
     sp_desc_cancel=¿Seguro que quieres cancelar los cambios realizados?
popupButton=xpath=//div[@class='modal-footer']/button[text()[contains(.,'Sí')]]
popupButton=xpath=//div[@class='modal-footer']/button[text()[contains(.,'No')]]

#################################################################################

&{dictCustViewProfileInfo}	btn_modifyProfile=btnEdit
...	btn_resetPassword=btnForgot
...	cb_approveDisclosure=commercialDisclosures
...	link_approveDisclosure=xpath=//*[@prefix-href[contains(.,'commercial-communication')]]
...	btn_resetCancel=xpath=//button[(text()='No')]
...	btn_resetYes=xpath=//button[(text()='Yes')]
...	btn_resetOK=//button[(text()='OK')]

*** Test Cases ***
Scenario1: Verify that Customer user is able to view Customer Profile Information section
#PASS
	[Tags]	ViewCustomerProfileInfo
	Open Chrome with  ${D4customer}
    Go to Customer View Profile Information page    TEnos@allianz.com    Allianz1234

Scenario2: Customer user is able to modify their Profile Information successfully
#	[Setup]	Data Setup for Modification Data
    Open Chrome with  ${D4customer}
    Go to Customer View Profile Information page    TEnos@allianz.com    Allianz1234

  Log  \n---- Select new value of ${MyProfileTitle} ----  console=yes
  sleep  1

	Enter Text into  ${MyProfileFirstName}        Euro
	Enter Text into  ${MyProfileLastname}         Time
	Enter Text into  ${MyProfilePostalCode}       29999
	Enter Text into  ${MyProfileMobile}           789456123
	click element   xpath=//select[@name='${MyProfileTitle}']//option[text()='Sra.']
  Log  \n---- Modify customer information success ----  console=yes
	Click following button  ${ProfileSubmit}


Scenario3: Customer user is able to view a Commercial Communications page
    Open Chrome with  ${D4customer}
    Go to Customer View Profile Information page    TEnos@allianz.com    Allianz1234

    # Click 'Disclouse' link
    Click following button  ${MyProfileDisclosure}
    Close Window
    Select Window	url=${customerlandingURL}commercial-disclosure-customer/

Scenario4: Customer user is able to cancel the data modification
    Open Chrome with  ${D4customer}
    Go to Customer View Profile Information page    TEnos@allianz.com    Allianz1234

#	Modify Existing User Information 	validModifyData001	${EMPTY} 	Submit
  Log  \n---- Select new value of ${MyProfileTitle} ----  console=yes
  sleep  1

	Enter Text into  ${MyProfileFirstName}        Euro
	Enter Text into  ${MyProfileLastname}         Time
	Enter Text into  ${MyProfilePostalCode}       29999
	Enter Text into  ${MyProfileMobile}           789456123
	click element   xpath=//select[@name='${MyProfileTitle}']//option[text()='Sra.']
  Log  \n---- Modify customer information success ----  console=yes
######################################################################################################

    # Click 'Cancel' on Edit Profile screen
    Click following button  ${ProfileCancel}
    Unselect Frame
    # Click 'No' on Cancel information pop-up
    Click following button  ${MyProfileCancelPopupNo}
    Select Frame	xpath=//iframe

    # Check screen header to confirm displayed screen is 'Modification Profile' screen
    Wait Until Page Does Not Contain Element  xpath=//*[@class='loading-iframe ng-scope']
	Wait Until Element Is Visible  //*[@id="ng-app"]/body/div[1]/div[1]/div/h3
    Element Text Should Be  xpath=//*[@id="ng-app"]/body/div[1]/div[1]/div/h3    MODIFICAR PERFIL

  sleep  1
    # Click 'Cancel' on Edit Profile screen
    Click following button  ${ProfileCancel}
    Unselect Frame
    # Click 'Yes' on Cancel information pop-up
    Click following button  ${MyProfileCancelPopupYes}
    Select Frame	xpath=//iframe

    # Check screen header to confirm displayed screen is 'View My Profile' screen
    Wait Until Page Does Not Contain Element  xpath=//*[@class='loading-iframe ng-scope']
	Wait Until Element Is Visible  //*[@id="ng-app"]/body/div[1]/div[1]/div[1]/h3
    Element Text Should Be  xpath=//*[@id="ng-app"]/body/div[1]/div[1]/div[1]/h3    MI PERFIL

##### CustRegistration.Customer Commercial Communications window should be opened

Scenario5: Customer user should see error message appears while submitting data with invalid conditions
    Open Chrome with  ${D4customer}
    Go to Customer View Profile Information page    TEnos@allianz.com    Allianz1234

*** Keywords ***
Go to Customer View Profile Information page
    [Arguments]  ${User}  ${Pws}
  Log  \n---- Browser was open and display Landing page ----  console=yes
    Wait Until Page Does Not Contain Element  ${LoadingElement}
    Select Frame	xpath=//iframe
    Wait Until Page Does Not Contain Element  ${LoadingElement}
    Enter Text into  ${LoginUsername}    ${User}
    Enter Text into  ${LoginPassword}    ${Pws}
    Click following button  ${LoginButton}

  Log  \n---- Login success enter to customer area page ----  console=yes
 #   xpath=//a[@href[contains(.,'create-new-account')]]
 #   Element Text Should Be    xpath=//*[@id="ng-app"]/body/div[1]/div[1]/div/div/div/div[1]/div[1]/h1    ÁREA DEL CLIENTE
    Wait Until Page Does Not Contain Element  ${LoadingElement}
    Wait Until Element Is Visible    ${ViewMyProfile}
	Click Element    ${ViewMyProfile}
  Log  \n---- Move to My Profile screen ----  console=yes
	Wait Until Page Does Not Contain Element  ${LoadingElement}
	Wait Until Element Is Visible  ${MyProfileHeader}
    Element Text Should Be  ${MyProfileHeader}    MI PERFIL
  Log  \n---- Check header success and click 'Profile edit' ----  console=yes
    Wait Until Page Does Not Contain Element  ${LoadingElement}
    sleep  1
    Wait Until Element Is Visible  xpath=//*[@class='fntb btn-grey mobile-full-block ng-scope']
#    wait until element contains
#    Wait Until Element Is Visible  //*[@id="ng-app"]/body/div[1]/div[1]/div[1]/h3
#    Element Text Should Be  xpath=//*[@id="ng-app"]/body/div[1]/div[1]/div[1]/h3    MI PERFIL
    Click following button    ${ProfileEdit}
    Wait Until Page Does Not Contain Element  ${LoadingElement}
  Log  \n---- Modification Profile screen is displaying on screen ----  console=yes
    sleep  2    ### Use for waiting page load all elements and information
######################################################################################################


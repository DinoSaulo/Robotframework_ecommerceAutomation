*** Settings ***
Library    SeleniumLibrary

*** Variables ***

*** Keywords ***
### Hooks
Open the browser
    Open Browser        ${URL}      ${BROWSER}
    Set Window Size     1200    800

### Steps test scenario

### ------------------------------------ GIVEN ------------------------------------
Given I am in the "${page}" page
    IF  $page == "home"
        Execute JavaScript    window.location.href='/'
    ELSE
        Log     "Error page not defined"
    END

### ------------------------------------ WHEN ------------------------------------
When I click on "${tabName}" tab
    Click Element   xpath://a[text()='${tabName}']

And I click on Quick View for the first item
    Scroll Element Into View    xpath:(//div[@class='product-image-container'])[1]
    Execute JavaScript    document.evaluate("(//a[@class='quick-view'])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.style.display = "block";
    Click Element   xpath:(//a[@class='quick-view'])[1]
    Wait Until Element Is Visible    xpath://body[@id='product']

### ------------------------------------ THEN ------------------------------------
Then I should see the website logo
    Element Should Be Visible  id:header_logo
    Element Attribute Value Should Be   css:img[alt='My Shop']  src   ${BASE_URL}/img/logo.jpg

And I should see the sale image
    Element Should Be Visible  xpath://header[@id='header']//a/img[@class='img-responsive']

And I should see the search bar
    Element Should Be Visible   css:button[name='submit_search']
    Element Should Be Visible   id:search_query_top
    Element Attribute Value Should Be   id:search_query_top     placeholder     Search
    Element Attribute Value Should Be   id:searchbox    method      get
    Element Attribute Value Should Be   id:searchbox    action      ${URL}?controller=search

And I should see the "${firstOption}", "${secondOption}", "${thirdOption}" and "${fourthOption}" menu categories
    Element Should Be Visible   xpath://div[@id='block_top_menu']/ul/li/a[@title='Women']
    Element Should Contain  xpath://div[@id='block_top_menu']/ul/li/a[@title='Women']    ${firstOption}

    Element Should Be Visible   xpath://div[@id='block_top_menu']/ul/li/a[@title='Dresses']
    Element Should Contain  xpath://div[@id='block_top_menu']/ul/li/a[@title='Dresses']    ${secondOption}

    Element Should Be Visible   xpath://div[@id='block_top_menu']/ul/li/a[@title='T-shirts']
    Element Should Contain  xpath://div[@id='block_top_menu']/ul/li/a[@title='T-shirts']    ${thirdOption}

    Element Should Be Visible   xpath://div[@id='block_top_menu']/ul/li/a[@title='Blog']
    Element Should Contain  xpath://div[@id='block_top_menu']/ul/li/a[@title='Blog']    ${fourthOption}

And I should see the Cart button
    Element Should Be Visible   //div[@class='shopping_cart']/a

And I should see the Contact Us and Login button
    Element Should Be Visible   id:contact-link
    Element Should Contain  id:contact-link     Contact us
    Element Should Be Visible   xpath://div[@class='header_user_info']/a
    Element Should Contain  //div[@class='header_user_info']/a  Sign in

Then I receive the message "${message}" on home page
    Element Should Contain  xpath://ul[@id='homefeatured']/li  No featured products at this time

Then I see some products on the home page
    ${COUNT}    Get Element Count    xpath://ul[@id='blockbestsellers']/li
    Should Be True    ${COUNT} != 0

Then I see a modal with some data of the product
    Element Should Be Visible   id:short_description_content
    Element Should Be Visible   id:product_condition
    Element Should Be Visible   id:product_reference

And I see the product images
    Element Should Be Visible   id:bigpic  
    ${COUNT}    Get Element Count    id:thumbs_list_frame
    Should Be True    ${COUNT} != 0

And I see the product price, size input and available colors
    Element Should Be Visible   id:color_to_pick_list
    Element Should Be Visible   id:uniform-group_1
    Element Should Be Visible   id:our_price_display

        
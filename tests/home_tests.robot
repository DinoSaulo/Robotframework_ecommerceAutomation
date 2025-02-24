*** Settings ***
Documentation   Home pages tests from the e-commerce
...             As a user
...             I want to view the home page
...             So that I can see the main sections of the website

Library    SeleniumLibrary
Resource   ../resources/global_variables.robot
Resource   ../resources/steps/home_steps.robot

Test Setup      Open the browser

*** Test Cases ***
#Feature: Home Page Display

Scenario: Home Page Loads Successfully the header elements
  Given I am in the "home" page
  Then I should see the website logo
  And I should see the sale image
  And I should see the search bar
  And I should see the "WOMEN", "DRESSES", "T-SHIRTS" and "BLOG" menu categories
  And I should see the Cart button
  And I should see the Contact Us and Login button

Scenario: Home Page should not contains products on Popular tab 
  Given I am in the "home" page
  When I click on "Popular" tab
  Then I receive the message "No featured products at this time" on home page

Scenario: Home Page should contains some products on Best Sellers tab 
  Given I am in the "home" page
  When I click on "Best Sellers" tab
  Then I see some products on the home page

Scenario: Home Page should contains some products on Best Sellers tab 
  Given I am in the "home" page
  When I click on "Best Sellers" tab
  And I click on Quick View for the first item
  Then I see a modal with some data of the product
  And I see the product images
  And I see the product price, size input and available colors
  
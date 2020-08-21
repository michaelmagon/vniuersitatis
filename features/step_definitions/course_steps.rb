require 'selenium-webdriver'
require 'rspec'

driver = Selenium::WebDriver.for:chrome 
base_url = "http://localhost:3000/"


Given(/^I am at the home screen$/) do
  driver.navigate.to base_url
end

Given(/^I am logged in as a "([^"]*)"$/) do |term|
  driver.navigate.to "#{base_url}users/sign_in"
  sleep(2)   
  
  driver.find_element(:id, 'user_email').send_keys TestSeed.get_user(term)
  driver.find_element(:id, 'user_password').send_keys "123456"

  driver.find_element(:id,'new_user').submit
  sleep(2) 
end

Given(/^I am viewing an "([^"]*)" Course$/) do |term|
  driver.navigate.to base_url+"/course/sample-of-#{term}-course"
  sleep(2)
end

When(/^I click on Currently Running Courses Filter$/)do    
  driver.find_element(:xpath, '/html/body/div[1]/section[1]/div/div/ul/li[3]/a').click
  sleep(2)
end

When(/^I click on a course$/) do 
  driver.find_element(:xpath, '/html/body/div[1]/section[2]/div[1]/div[2]/a').click
  sleep(2)
end

When(/^I click on Join Course$/) do
  driver.find_element(:xpath, '//*[@id="apply-course"]').click
  sleep(2)
end

When(/^I click on My Courses$/) do
  driver.find_element(:xpath, '/html/body/nav/div/div/ul/li[2]/a').click
  sleep(2)
end

Then(/^I should be redirected to Course lists$/) do
  current_url = driver.current_url
  expect(current_url).to eq('http://localhost:3000/courses/list')    
end

Then(/^I should be redirected to Course$/) do
  current_url = driver.current_url
  expect(current_url).to start_with('http://localhost:3000/course')    
end

Then(/^I should be redirected to My Courses$/) do
  current_url = driver.current_url
  expect(current_url).to eq('http://localhost:3000/my_courses')
end

Then(/^I should see courses$/) do  
  courses = driver.find_elements(:class, 'course_tab').length
  expect(courses).to be > 0
end

Then(/^I should be notified$/) do  
  courses = driver.find_element(:xpath, '/html/body/div[1]/div[1]/div/strong')

  expect(courses.text).to eq('Successfully applied for a spot!')
end

Then(/^I should not see Create course button$/) do  
  create_course = driver.find_elements(:xpath, '//*[@id="create_course"]').length
  expect(create_course).to be == 0
end
Given(/^I am on the "(.*?)" homepage$/) do |institution|
  @landing_page.load_page institution
end

When(/^I log in to "(.*?)"$/) do |institution|
  @config.deployment = Deployment::DEPLOYMENTS.find { |d| d.code == institution }
  @admin = @config.get_admin_user
  @landing_page.click_sign_in
  @login_page.log_in(@admin.username, @admin.password)
end

When(/^I click the app "(.*?)"/) do |app|
  @landing_page.click_app app
end

Then(/^I will sign out$/) do
  @landing_page.log_out
end

Then(/^I check for the user icon image$/) do
  expect(@landing_page.exists? @landing_page.user_icon).to be true
end

When(/^I sign in to "(.*?)"$/) do |institution|
  @config.deployment = Deployment::DEPLOYMENTS.find { |d| d.code == institution }
  @admin = @config.get_admin_user
  @login_page.log_in(@admin.username, @admin.password)
end

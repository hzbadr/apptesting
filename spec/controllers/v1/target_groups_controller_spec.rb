require 'rails_helper'

RSpec.describe V1::TargetGroupsController, type: :controller do
  let!(:user) { create(:user, email: "foo@bar.com", password: "1234") }
  let!(:panel_provider) { create(:panel_provider) }
  let!(:country) { create(:country, country_code: "US", panel_provider_id: panel_provider.id) }

  let!(:target_groups) do
    roots = 2.times.map do |i|
      create(:target_group, name: "target#{i}", panel_provider_id: panel_provider.id)
    end

    children = roots.map do |root|
      create(:target_group, name: "#{root.name}#{rand(1..10)}",
             panel_provider_id: root.panel_provider_id, parent_id: root.id)
    end
    roots + children
  end

  let!(:another_panel_provider) { create(:panel_provider) }
  let!(:another_country) { create(:country, country_code: "FR", panel_provider_id: another_panel_provider.id) }
  let!(:another_target_group) { create(:target_group, panel_provider_id: another_panel_provider.id) }

  let!(:headers) do
    { 'Authorization': AuthenticateUser.new(user.email, user.password).call }
  end

  it "return status is 200 for valid country code" do
    request.headers.merge!(headers)
    get :list, params: { country_code: country.country_code }
    expect(response.status).to eq(200)
  end

  # HZ: should be moved to requests spec.
  it "return correct target groups" do
    request.headers.merge!(headers)
    get :list, params: { country_code: country.country_code }
    target_group_names = json_body["target_groups"].map { |target| target["name"] }
    expect(target_group_names).to match_array(target_groups.map(&:name))
  end

  it "return status is 404 for invalid country code" do
    request.headers.merge!(headers)
    get :list, params: { country_code: "xyz" }
    expect(response.status).to eq(404)
  end

  it "return status is 422 for un authorized user" do
    get :list, params: { country_code: country.country_code }
    expect(response.status).to eq(422)
  end
end

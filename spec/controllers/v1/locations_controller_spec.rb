require 'rails_helper'

RSpec.describe V1::LocationsController, type: :controller do
  let!(:user) { create(:user, email: "foo@bar.com", password: "1234") }
  let!(:panel_provider) { create(:panel_provider) }
  let!(:country) { create(:country, panel_provider_id: panel_provider.id) }
  let!(:location_group) { create(:location_group, country_id: country.id,
                                 panel_provider_id: country.panel_provider_id) }

  let!(:locations) do
    3.times.map do |i|
      location_group.locations.create(name: "location#{i}", secret_code: "1234",
                                      external_id: 1234)
    end
  end

  let!(:another_panel_provider) { create(:panel_provider) }
  let!(:another_country) { create(:country, panel_provider_id: another_panel_provider.id) }
  let!(:another_location_group) { create(:location_group, country_id: another_country.id,
                          panel_provider_id: another_country.panel_provider_id) }
  let!(:another_locations) do
    3.times.map do |i|
      another_location_group.locations.create(name: "location#{i}", secret_code: "1234",
                                      external_id: 1234)
    end
  end

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
    locations_names = json_body["locations"].map { |target| target["name"] }
    expect(locations_names).to match_array(locations.map(&:name))
  end

  it "return status is 404 for invalid country code" do
    request.headers.merge!(headers)
    get :list, params: { country_code: "xyz" }
    expect(response.status).to eq(404)
  end

  it "return status is 422 for un authorized user" do
    get :list, params: { country_code: country.country_code}
    expect(response.status).to eq(422)
  end
end

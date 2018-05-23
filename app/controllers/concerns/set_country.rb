module SetCountry
  private
    def country
      @country = Country.find_by(country_code: params[:country_code])
      @country || raise(ActiveRecord::RecordNotFound, "Country code does not exist")
    end
end

require 'spec_helper'

describe DebitsController do

  before do
      @member = Member.create({
      first_name: "fname", last_name: "lname",
      date_of_birth: "1989-03-13", date_of_join: "2012-08-15",
      qualification: Member::QUALIFICATIONS["B.Com"], address: "address for \n communication",
      password: "password", password_confirmation: "password" })
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', id: @member
      response.should be_success
    end
  end

end

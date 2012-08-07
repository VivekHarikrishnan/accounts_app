require 'spec_helper'

describe MembersController do
  before do    
    @member = Member.create({
        first_name: "fname", last_name: "lname",
        date_of_birth: "1989-03-13", date_of_join: "2012-08-15",
        qualification: Member::QUALIFICATIONS["B.Com"], address: "address for \n communication"
      })
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do      
      get 'edit', id: @member
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: @member
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end

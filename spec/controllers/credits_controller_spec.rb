require 'spec_helper'

describe CreditsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create', credit: {}
      response.should be_success
    end
  end

end

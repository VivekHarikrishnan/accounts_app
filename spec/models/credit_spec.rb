require 'spec_helper'

describe Credit do
  before { @credit = Credit.new }

  subject { @credit }

  it { should respond_to :member }
  it { should respond_to :dot }
  it { should respond_to :date_of_transaction }
  it { should respond_to :amount }

  describe "Validations" do
    before do
      member = Member.create({
          first_name: "fname", last_name: "lname",
          date_of_birth: "1989-03-13", date_of_join: "2012-08-15",
          qualification: Member::QUALIFICATIONS["B.Com"], address: "address for \n communication",
          password: "password", password_confirmation: "password" })

      @valid_attributes = { member_id: member.id,
        amount: 110, date_of_transaction:  "2012-03-08" }
    end

    it "throws error upon member_id is not present" do
      credit = Credit.create(@valid_attributes.except(:member_id))
      credit.should_not be_valid
      credit.errors[:member_id].first.should == "can't be blank"
    end

    it "throws error upon amount is not present" do
      credit = Credit.create(@valid_attributes.except(:amount))
      credit.should_not be_valid
      credit.errors[:amount].first.should == "can't be blank"
    end

    it "throws error upon amount is not a decimal value" do
      credit = Credit.create(@valid_attributes.merge(amount: "abcd"))
      credit.should_not be_valid
      credit.errors[:amount].first.should == "is not a number"
    end
    
    it "throws error upon amount is less than 0.0" do
      credit = Credit.create(@valid_attributes.merge(amount: -10.0))
      credit.should_not be_valid
      credit.errors[:amount].first.should == "must be greater than 0.0"
    end

    it "throws error upon date of transaction is not present" do
      credit = Credit.create(@valid_attributes.except(:date_of_transaction))
      credit.should_not be_valid
      credit.errors[:date_of_transaction].first.should == "can't be blank"
    end
  end
  end

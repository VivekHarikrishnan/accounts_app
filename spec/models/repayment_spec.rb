require 'spec_helper'

describe Repayment do
  before { @repayment = Repayment.new }
  subject { @repayment }

  it { should respond_to :member }
  it { should respond_to :amount }
  it { should respond_to :date_of_transaction }
  it { should respond_to :dot }

  describe "validations" do
    before do
      @valid_attributes = { member_id: "1", amount: 500,
                            date_of_transaction: "2012-08-12"}
    end

    it "should validate member id presence" do
      repayment = Repayment.create(@valid_attributes.except(:member_id))
      repayment.should_not be_valid
      repayment.errors[:member_id].first.should == "can't be blank"
    end

    it "should not make a transaction if date of transaction is not given" do
      repayment = Repayment.create(@valid_attributes.except(:date_of_transaction))
      repayment.should_not be_valid
      repayment.errors[:date_of_transaction].first.should == "can't be blank"
    end

    it "should be invalid if amount is not given" do
      repayment = Repayment.create(@valid_attributes.except(:amount))
      repayment.should_not be_valid
      repayment.errors[:amount].first.should == "can't be blank"
    end

    it "should not create a transaction of amount is not a number" do
      repayment = Repayment.create(@valid_attributes.merge(amount: "abcd"))
      repayment.should_not be_valid
      repayment.errors[:amount].first.should == "is not a number"
    end

    it "should not creat a transaction if amount is less than 0.0" do
      repayment = Repayment.create(@valid_attributes.merge(amount: -100))
      repayment.should_not be_valid
      repayment.errors[:amount].first.should == "must be greater than 0.0"
    end

    it "should make a transaction if member, date of transaction and amount is present" do
      repayment = Repayment.create(@valid_attributes)
      repayment.should be_valid
    end
  end

end

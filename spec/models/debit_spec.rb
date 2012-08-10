require 'spec_helper'

describe Debit do
  before :all do
    Credit.all.collect { |x| x.destroy}
    Member.all.collect { |x| x.destroy}
    Debit.all.collect { |x| x.destroy}
  end

  before :each do
    @member = Member.create({
        first_name: "fname", last_name: "lname",
        date_of_birth: "1989-03-13", date_of_join: "2012-08-15",
        qualification: Member::QUALIFICATIONS["B.Com"], address: "address for \n communication",
        password: "password", password_confirmation: "password" })
    
    Credit.create([{ member_id: @member.id, amount: 110, date_of_transaction: "2012-08-12"},
        { member_id: @member.id, amount: 110, date_of_transaction: "2012-09-12"},
        { member_id: @member.id, amount: 110, date_of_transaction: "2012-10-12"},
        { member_id: @member.id, amount: 110, date_of_transaction: "2012-11-12"},
        { member_id: @member.id, amount: 110, date_of_transaction: "2012-12-12"}])
    @debit = Debit.new    
  end

  it { should respond_to :member}
  it { should respond_to :date_of_transaction}
  it { should respond_to :amount}
  it { should respond_to :dot}

  describe "validations" do
    before do
      @valid_attributes = { member_id: @member.id, amount: 200,
        date_of_transaction: "2012-08-12"}
    end

    it "should validate member id presence" do
      debit = Debit.create(@valid_attributes.except(:member_id))
      debit.should_not be_valid
      debit.errors[:member_id].first.should == "can't be blank"
    end

    it "should not make a transaction if date of transaction is not given" do
      debit = Debit.create(@valid_attributes.except(:date_of_transaction))
      debit.should_not be_valid
      debit.errors[:date_of_transaction].first.should == "can't be blank"
    end

    it "should be invalid if amount is not given" do
      debit = Debit.create(@valid_attributes.except(:amount))
      debit.should_not be_valid
      debit.errors[:amount].first.should == "can't be blank"
    end

    it "should not create a transaction of amount is not a number" do
      debit = Debit.create(@valid_attributes.merge(amount: "abcd"))
      debit.should_not be_valid
      debit.errors[:amount].first.should == "is not a number"
    end

    it "should not creat a transaction if amount is less than 0.0" do
      debit = Debit.create(@valid_attributes.merge(amount: -100))
      debit.should_not be_valid
      debit.errors[:amount].first.should == "must be greater than 0.0"
    end

    it "should make a transaction if member, date of transaction and amount is present" do
      debit = Debit.create(@valid_attributes)
      debit.should be_valid
    end

    it "should not make a transaction when debit amount is greater than amount in sum of amount in Credit" do
      debit = Debit.create({ member_id: @member, amount: 600, date_of_transaction: "2012-12-12"})      
      debit.should_not be_valid
      debit.errors[:amount].first.should == "is invalid. No enough amount to debit (available amount: #{CURRENCY} #{Credit.total_amount})"
    end

    it "should make a transaction if amount is less than total amount in Credit" do
      debit = Debit.create({ member_id: @member, amount: 550, date_of_transaction: "2012-12-12"})
      debit.should be_valid
      debit.errors.should be_blank
    end
  end
end

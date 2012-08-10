require 'spec_helper'

describe Member do
  before do
    @member = Member.new
  end
  subject { @member }

  it { should respond_to(:first_name)}
  it { should respond_to(:last_name)}
  it { should respond_to(:date_of_birth)}
  it { should respond_to(:date_of_join)}
  it { should respond_to(:qualification)}
  it { should respond_to(:address)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:credits)}
  it { should respond_to(:debits)}
  it { should respond_to(:repayments)}
  it do
    pending "Yet to implement photo uploading feature"
    should respond_to(:photo)
  end

  describe "Validations" do

    before do
      @valid_attributes = {
        first_name: "fname", last_name: "lname",
        date_of_birth: "1989-03-13", date_of_join: "2012-08-15",
        qualification: Member::QUALIFICATIONS["B.Com"], address: "address for \n communication",
        password: "password", password_confirmation: "password"
      }
    end

    it "should be invalid if first name or last name is not given" do
      member = Member.create(@valid_attributes.except(:first_name, :last_name))
      member.should_not be_valid
      member.errors[:first_name].first.should == "can't be blank"
      member.errors[:last_name].first.should == "can't be blank"      
    end

    it "should not allow to save a member if last name is already taken" do
      member1 = Member.create(@valid_attributes)
      member1.should be_valid
      member2 = Member.create(@valid_attributes)
      member2.should_not be_valid
      member2.errors[:last_name].first.should == "has already been taken"
    end

    it "should be invalid if date of birth and date of join is blank" do
      member = Member.create(@valid_attributes.except(:date_of_birth, :date_of_join))
      member.should_not be_valid
      member.errors[:date_of_birth].first.should == "can't be blank"
      member.errors[:date_of_join].first.should == "can't be blank"
    end

    it "should not be a valid member if address or qualification is not given" do
      member = Member.create(@valid_attributes.except(:address, :qualification))
      member.should_not be_valid
      member.errors[:address].first.should == "can't be blank"
      member.errors[:qualification].first.should == "can't be blank"
    end

    it "should save qualification in lower case letters before save a member" do
      member = Member.create(@valid_attributes)
      member.qualification.should_not == "BCOM"
      member.qualification.should_not == "B.Com"
      member.qualification.should == "bcom"
    end

    it "should have only the qualifications that are available" do
      pending "To implement inclusion"
      member = Member.create(@valid_attributes.merge(qualification: "TEACHER"))
      member.should_not be_valid
      member.errors[:qualification].first.should == "is not included in the list"
    end

    it "should save a member if all the attributes are valid" do
      member = Member.create(@valid_attributes)
      member.should be_valid
    end
  end

  describe "Transaction" do
    before do
      @member = Member.create({ first_name: "fname", last_name: "lname",
          date_of_birth: "1989-03-13", date_of_join: "2012-08-15",
          qualification: Member::QUALIFICATIONS["B.Com"], address: "address for \n communication",
          password: "password", password_confirmation: "password" })

      Credit.create([{ member_id: @member.id, amount: 200, date_of_transaction: "2012-08-12"},
          { member_id: @member.id, amount: 200, date_of_transaction: "2012-09-12"},
          { member_id: @member.id, amount: 200, date_of_transaction: "2012-10-12"},
          { member_id: @member.id, amount: 200, date_of_transaction: "2012-11-12"},
          { member_id: @member.id, amount: 200, date_of_transaction: "2012-12-12"}])

      Debit.create({ member_id: @member.id, amount: 500, date_of_transaction: "2012-08-12"})

      Repayment.create([{ member_id: @member.id, amount: 200, date_of_transaction: "2012-08-12"},
          { member_id: @member.id, amount: 150, date_of_transaction: "2012-09-12"}])
    end
    
    it "should return sum of credits amount as 1000" do
      @member.credit_amount.should == 1000
    end

    it "should return sum of debits amount as 500" do
      @member.debit_amount.should == 500
    end

    it "should return amount to repay as 1000" do
      @member.amount_to_repay.should == 150
    end
  end
  
end

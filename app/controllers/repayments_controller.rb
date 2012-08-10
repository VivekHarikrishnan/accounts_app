class RepaymentsController < ApplicationController
  def new
    @repayment = Repayment.new
    @members = Member.all.collect {|m| [m, m.id]}
  end

  def create
    @repayment = Repayment.new(params[:repayment])

    if @repayment.save
      redirect_to members_path, notice: "repayment made successfully"
    else
      @members = Member.all.collect {|m| [m, m.id]}
      render :new
    end
  end

  def index
    @member = Member.find(params[:id])
    @repayments = @member.repayments
  end
end

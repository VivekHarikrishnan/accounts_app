class DebitsController < ApplicationController
  def new
    @debit = Debit.new
    @members = Member.all.collect {|m| [m, m.id] }
  end

  def create
    @debit = Debit.new(params[:debit])

    if @debit.save
      redirect_to members_path, notice: "Successfully withdrawn amount"
    else
      @members = Member.all.collect {|m| [m, m.id] }
      render :new
    end
  end

  def index
    @member = Member.find(params[:id])
    @debits = @member.debits
  end
end

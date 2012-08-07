class MembersController < ApplicationController
  def new
    @member = Member.new
  end

  def create
    @member = Member.new(params[:member])

    if @member.save
      redirect_to members_path, notice: "Member created successfully"
    else
      render :new
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])

    if @member.update_attributes(params[:member])
      redirect_to members_path, notice: "Member details updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to members_path, notice: "Member deleted successfully"
  end

  def index
    @members = Member.all    
  end

  def show
    @member = Member.find(params[:id])    
    @columns = Member.column_names
    @columns.delete("id")
    @columns.delete("created_at")
    @columns.delete("updated_at")
  end
end

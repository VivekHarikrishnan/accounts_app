class MembersController < ApplicationController
  before_filter :signed_in_user, only: [:new, :edit, :destroy]

  def home
  end
  
  def new
    @member = Member.new
  end

  def create
    member_attributes = params[:member].merge(password: "ezhil",
                                              password_confirmation: "ezhil")
    @member = Member.new(member_attributes)

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
    member_attributes = params[:member].merge(password: "ezhil",
                                              password_confirmation: "ezhil")
    if @member.update_attributes(member_attributes)
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
    @members = Member.all.collect { |m| [m, m.id]}
  end

  private

  def signed_in_user
    Rails.logger.info "User signed in successfully #{current_member} at #{Time.now}"
    redirect_to signin_path, notice: "Please sigin in" unless signed_in?
  end
end

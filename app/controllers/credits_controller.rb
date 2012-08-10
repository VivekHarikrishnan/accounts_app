class CreditsController < ApplicationController
  def new
    @credit = Credit.new
    @members = Member.all.collect {|m| [m, m.id] }
    @members.insert(0, ["All Members", "all"])
  end

  def create
    @credit = Credit.new(params[:credit])
    
    if params[:credit][:member_id] == "all"
      members = Member.all
      members_count = members.count
      members.each { |member| member.credits.create(params[:credit]) }
      redirect_to members_path, notice: "Credit transactions made
                        successfully for #{members_count} #{"member".pluralize(members_count)}"
    else
      
      if @credit.save
        redirect_to members_path, notice: "Credit transaction made successfully"
        
      else
        @members = Member.all.collect {|m| [m, m.id] }
        @members.insert(0, ["All Members", "all"])
        
        render :new
      end
    end
  end

  def index
    if params[:id].nil?
      redirect_to members_path, notice: "Member should be selected to view transactions"
    else
      @member = Member.find(params[:id])
      @credits = @member.credits
    end
  end
end

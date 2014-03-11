class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]

  # GET /proposals
  # GET /proposals.json
  def index
    @proposals = Proposal.where(issue_id: params[:issue_id])
    issue = Issue.find_by(id: params[:issue_id])
    fund = SocialFund.order("fiscal_year DESC").first
    if fund.present?
      @avl_cat_fund = issue.category == "Any Cause" ? fund.fund_for_others : fund.send("fund_for_#{issue.category.downcase}")
      if @avl_cat_fund == 0 && fund.fund_for_others > 0
        @avl_cat_fund = fund.fund_for_others
      end
    else
      @avl_cat_fund = 0
    end 
    @project = Project.find_by(issue_id: params[:issue_id])
  end

  # GET /proposals/1
  # GET /proposals/1.json
  def show
    @issue = Proposal.where(id: params[:id]).first
  end

  # GET /proposals/new
  def new
    @proposal = Proposal.new
  end

  # GET /proposals/1/edit
  def edit
    @issue = Proposal.where(id: params[:id]).first
  end

  # POST /proposals
  # POST /proposals.json
  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.user_id = current_user.id
    if @proposal.save
      issue = Issue.where(id: params[:proposal][:issue_id]).first
      current_user.issues << issue
      redirect_to issues_path
    end
  end

  # PATCH/PUT /proposals/1
  # PATCH/PUT /proposals/1.json
  def update
    @proposal.update(proposal_params)
    redirect_to :action => "my_proposals"
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  def destroy
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to proposals_url }
      format.json { head :no_content }
    end
  end

  # proposals for current user
  def my_proposals
    @proposals = Proposal.where(user_id: current_user.id)
    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_params
      params.require(:proposal).permit(:issue_id, :proposed_cost, :proposed_duration, :desc, :accepted, :user_id)
    end
end

class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]

  # GET /proposals
  # GET /proposals.json
  def index
    @proposals = Proposal.all
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
    respond_to do |format|
      if @proposal.save
        redirect_to issues_path
      end
    end
  end

  # PATCH/PUT /proposals/1
  # PATCH/PUT /proposals/1.json
  def update
    respond_to do |format|
      if @proposal.update(proposal_params)
        format.html { redirect_to @proposal, notice: 'Proposal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_params
      params.require(:proposals).permit(:issue_id, :proposed_cost, :proposed_duration, :desc, :accepted, :user_id)
    end
end

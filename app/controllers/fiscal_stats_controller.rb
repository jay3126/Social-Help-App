class FiscalStatsController < ApplicationController
  before_action :set_fiscal_stat, only: [:show, :edit, :update, :destroy] 

  # GET /fiscal_stats
  # GET /fiscal_stats.json
  def index
    @fiscal_stats = FiscalStat.all.where(user_id: current_user.id)
  end

  # GET /fiscal_stats/1
  # GET /fiscal_stats/1.json
  def show
  end

  # GET /fiscal_stats/new
  def new
    @fiscal_stat = FiscalStat.new()
  end

  # GET /fiscal_stats/1/edit
  def edit
  end

  # POST /fiscal_stats
  # POST /fiscal_stats.json
  def create
    @fiscal_stat = FiscalStat.new(issue_params)
    @fiscal_stat[:user_id] = current_user.id
    @fiscal_stat[:eligibility_status] = true if @fiscal_stat[:net_profit].to_i > Constants::EligibilityCriteria
    
    respond_to do |format|
      if @fiscal_stat.save
        format.html { redirect_to @fiscal_stat, notice: 'Fiscal stat was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fiscal_stat }
      else
        format.html { render action: 'new' }
        format.json { render json: @fiscal_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fiscal_stats/1
  # PATCH/PUT /fiscal_stats/1.json
  def update
    respond_to do |format|
      if @fiscal_stat.update(issue_params)
        format.html { redirect_to @fiscal_stat, notice: 'Fiscal stat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fiscal_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fiscal_stats/1
  # DELETE /fiscal_stats/1.json
  def destroy
    @fiscal_stat.destroy
    respond_to do |format|
      format.html { redirect_to fiscal_stats_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fiscal_stat
      @fiscal_stat = FiscalStat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fiscal_stat_params
      params[:fiscal_stat]
    end

    def issue_params
      params.require(:fiscal_stat).permit(:fiscal_year, :opening_blnc, :closing_blnc, :currency_type, :total_revenue, :net_profit, :available_social_fund, :user_id, :eligibility_status)
    end
end

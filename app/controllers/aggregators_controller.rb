class AggregatorsController < ApplicationController
  before_action :set_aggregator, only: [:show, :edit, :update, :destroy]

  # GET /aggregators
  # GET /aggregators.json
  def index
    user = get_current_user
    if user
       @aggregator = Aggregator.find_by_owner_id(user)
      render layout: 'angular'
    end
  end

  def search
    user = get_current_user
    if user
      @aggregator = Aggregator.find_by_owner_id(user)
      results = []
      Connection.search(params[:search], where: {id: @aggregator.connections.map(&:id)}).each do |connection|
        next if connection.profile == nil
        results.push connection.profile
      end
      render json: results
    end
  end

  # GET /aggregators/1
  # GET /aggregators/1.json
  def show
  end

  def invite
    @aggregator = Aggregator.find_by_invite_key(params[:invite_key])
    session[:invite_key] = params[:invite_key]
  end

  # GET /aggregators/new
  def new
    @aggregator = Aggregator.new
  end

  # GET /aggregators/1/edit
  def edit
  end

  # POST /aggregators
  # POST /aggregators.json
  def create
    user = get_current_user
    @aggregator = Aggregator.new(aggregator_params)
    @aggregator.owner = user
    @aggregator.users = [user.id]

    respond_to do |format|
      if @aggregator.save
        format.html { redirect_to @aggregator, notice: 'Aggregator was successfully created.' }
        format.json { render action: 'show', status: :created, location: @aggregator }
      else
        format.html { render action: 'new' }
        format.json { render json: @aggregator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aggregators/1
  # PATCH/PUT /aggregators/1.json
  def update
    respond_to do |format|
      if @aggregator.update(aggregator_params)
        format.html { redirect_to @aggregator, notice: 'Aggregator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @aggregator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aggregators/1
  # DELETE /aggregators/1.json
  def destroy
    @aggregator.destroy
    respond_to do |format|
      format.html { redirect_to aggregators_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aggregator
      @aggregator = Aggregator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aggregator_params
      params.require(:aggregator).permit(:name)
    end
end

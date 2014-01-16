class PoolsController < ApplicationController
  before_action :set_pool, only: [:show, :edit, :update, :destroy]

  # GET /aggregators
  # GET /aggregators.json
  def index
    if @current_user
      @pools = @current_user.pools
    else
      render :splash
    end
  end

  def search
    @pool = @current_user.pools.find_by(id: params[:id])
    results = []
    Connection.search(params[:search], where: {id: @pool.connections.map(&:id)}).each do |connection|
      next if connection.profile == nil
      results.push connection.profile
    end
    render json: results
  end

  # GET /aggregators/1
  # GET /aggregators/1.json
  def show
    @pool = @current_user.pools.find_by(id: params[:id])
    render layout: 'angular'
  end

  def invite
    @pool = Pool.find_by_invite_key(params[:invite_key])
    session[:invite_key] = params[:invite_key]
  end

  # GET /aggregators/new
  def new
    @pool = Pool.new
  end

  # GET /aggregators/1/edit
  def edit
  end

  # POST /aggregators
  # POST /aggregators.json
  def create
    @pool = Pool.new(pool_params)
    @pool.owner = @current_user
    @pool.users.push @current_user

    respond_to do |format|
      if @pool.save
        format.html { redirect_to pool_path(@pool), notice: 'Aggregator was successfully created.' }
        format.json { render action: 'show', status: :created, location: pool_path(@pool) }
      else
        format.html { render action: 'new' }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aggregators/1
  # PATCH/PUT /aggregators/1.json
  def update
    respond_to do |format|
      if @pool.update(pool_params)
        format.html { redirect_to @pool, notice: 'Aggregator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aggregators/1
  # DELETE /aggregators/1.json
  def destroy
    @pool.destroy
    respond_to do |format|
      format.html { redirect_to aggregators_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pool
      @pool = Pool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pool_params
      params.require(:pool).permit(:name)
    end
end

class GuideItemsController < ApplicationController
  before_action :set_guide_item, only: [:show, :edit, :update, :destroy]

  # GET /guide_items
  # GET /guide_items.json
  def index
    @guide_items = GuideItem.all
  end

  # GET /guide_items/1
  # GET /guide_items/1.json
  def show
    render json: @guide_item
  end

  # GET /guide_items/new
  def new
    @guide_item = GuideItem.new
  end

  # GET /guide_items/1/edit
  def edit
  end

  # POST /guide_items
  # POST /guide_items.json
  def create
    @guide_item = GuideItem.new(guide_item_params)

    respond_to do |format|
      if @guide_item.save
        format.html { redirect_to @guide_item, notice: 'Guide item was successfully created.' }
        format.json { render json: @guide_item, :only => :id, :include => {:critter => { :only => [ :id, :name ]}}}
      else
        format.html { render :new }
        format.json { render json: @guide_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guide_items/1
  # PATCH/PUT /guide_items/1.json
  def update
    respond_to do |format|
      if @guide_item.update(guide_item_params)
        format.html { redirect_to @guide_item, notice: 'Guide item was successfully updated.' }
        format.json { render :show, status: :ok, location: @guide_item }
      else
        format.html { render :edit }
        format.json { render json: @guide_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guide_items/1
  # DELETE /guide_items/1.json
  def destroy
    @guide_item.destroy
    respond_to do |format|
      format.html { redirect_to guide_items_url, notice: 'Guide item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guide_item
      @guide_item = GuideItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guide_item_params
      params.require(:guide_item).permit(:section_id, :critter_id, :secion_index)
    end
end

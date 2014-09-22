class CrittersController < ApplicationController
  before_action :set_critter, only: [:show, :edit, :update, :destroy, :wikipedia_search]
  before_action :set_type

  # GET /critters
  # GET /critters.json
  def index
    #@critters = type_class.all
    @critters = type_class.paginate(:page => params[:page], :per_page => 30).order('name ASC')
  end

  # GET /critters/1
  # GET /critters/1.json
  def show
    @images = IdentifyingImage.images_for(@critter.id)
  end

  # GET /critters/new
  def new
    @critter = type_class.new
  end

  # GET /critters/1/edit
  def edit
  end

  # POST /critters
  # POST /critters.json
  def create
    @critter = Critter.new(critter_params)

    respond_to do |format|
      if @critter.save
        format.html { redirect_to @critter, notice: 'Critter was successfully created.' }
        format.json { render :show, status: :created, location: @critter }
      else
        format.html { render :new }
        format.json { render json: @critter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /critters/1
  # PATCH/PUT /critters/1.json
  def update
    respond_to do |format|
      if @critter.update(critter_params)
        format.html { redirect_to @critter, notice: 'Critter was successfully updated.' }
        format.json { render :show, status: :ok, location: @critter }
      else
        format.html { render :edit }
        format.json { render json: @critter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /critters/1
  # DELETE /critters/1.json
  def destroy
    @critter.destroy
    respond_to do |format|
      format.html { redirect_to critters_url, notice: 'Critter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def search
    @critters = Critter.where("name LIKE ?" , "%#{params[:term]}%")
    render json: @critters
  end
  
  def wikipedia_search
    critter_data = JSON.load(open(URI.encode("http://en.wikipedia.org/w/api.php?format=json&action=query&titles=" + params[:wikipedia_name] + "&prop=images")))
    #raise critter_data.inspect
    render json: critter_data["query"]["pages"].values[0]["images"]
    #@critter
    #@critter = type_class.create_from_wikipedia(params[:wikipedia_name],{:type => type, :name => params[:wikipedia_name]})
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_critter
      @critter = Critter.find(params[:id])
    end
    
    def set_type
       @type = type
    end
    
    def type
        #Critter.types.include?(params[:type]) ? params[:type] : "Critter"
        params[:type] ? params[:type] : "Critter"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def critter_params
      #raise params.inspect
      params.require(type.underscore.to_sym).permit(:name,:type)
    end
    
    def type_class 
        type.constantize 
    end
    
end

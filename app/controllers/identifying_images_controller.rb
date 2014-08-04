class IdentifyingImagesController < ApplicationController
  before_action :set_critter
  
  def index
    if params[:wikipedia_name]
      #raise "http://en.wikipedia.org/w/api.php?format=json&action=query&titles=#{params[:wikipedia_name]}&prop=images".inspect
      critter_data = JSON.load(open(URI.encode("http://en.wikipedia.org/w/api.php?format=json&action=query&titles=#{params[:wikipedia_name]}&prop=images")))
      #raise critter_data.inspect
      render json: critter_data["query"]["pages"].values[0]["images"]
    end
    #@critter
    #@critter = type_class.create_from_wikipedia(params[:wikipedia_name],{:type => type, :name => params[:wikipedia_name]})
  end
  
  def create
    
    @identifying_image = IdentifyingImage.new(identifying_image_params)
    if params[:remote_image_url]
      @identifying_image.image.remote_image_url = params[:remote_image_url]
    end
    respond_to do |format|
      if @identifying_image.save
        format.html { redirect_to critter_url(@critter), notice: 'Image was successfully created.' }
        format.json { render json: @critter.to_json, status: :created }
      else
        format.html { render :new }
        format.json { render json: @identifying_image.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  
  private
  
    def set_critter
      @critter = Critter.find(params[:critter_id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def identifying_image_params
      #raise params.inspect
      params.require(:critter_identifying_images).permit(:image,:remote_image_url,:critter_id,:attribution)
    end
  
end

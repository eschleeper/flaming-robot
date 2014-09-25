class IdentifyingImagesController < ApplicationController
  before_action :set_critter
  
  def index
    if params[:wikipedia_name]
      critter_data = Brototype::Bro.new(JSON.load(open(URI.encode("http://en.wikipedia.org/w/api.php?format=json&action=query&titles=#{params[:wikipedia_name]}&prop=images"))))
      critter_data.i_dont_always("query.pages").but_when_i_do(lambda { |page|
        render json: Brototype::Bro.new(page.values[0]).i_can_haz("images")
      })
    end
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
      params.require(:critter_identifying_images).permit(:image,:remote_image_url,:critter_id,:attribution)
    end
  
end

class Critter < ActiveRecord::Base
  
  has_many :identifying_images, dependent: :destroy
  has_many :guide_items, dependent: :destroy
  has_many :sections, through: :guide_items
  
  types = [
    "Bird",
    "Bug",
    "Herp",
    "Insect",
    "Mammal"
  ]
  
  scope :birds, -> { where(type: 'Bird') }
  scope :bugs, -> { where(type: 'Bug') }
  scope :herps, -> { where(type: 'Herp') }
  scope :insect, -> { where(type: 'Insect') }
  scope :mammals, -> { where(type: 'Mammal') }
  
  def as_json(options = {})
    super(:only => [:id, :name], :include => {
      :identifying_images => { :only => [ :image, :attribution ] }
    })
  end
  
  def self.create_from_wikipedia(name,critter_params)
    image_string = ""
    for image in critter_data["query"]["pages"].values[0]["images"]
      image_string = image_string + image["title"].tr(" ", "_") + "|"
      #new_image = IdentifyingImage.new
      #new_image.remote_image_url = image["url"]
      #new_image.save
    end
    #raise "http://commons.wikimedia.org/w/api.php?action=query&titles=#{URI.encode(image_string)}&prop=pageimages&format=json".inspect
    image_data = JSON.load(open("http://commons.wikimedia.org/w/api.php?action=query&titles=#{URI.encode(image_string)}&prop=pageimages&format=json"))
    for image in image_data["query"]["pages"]
      unless image[0] == "-1"
        raise image[1].inspect
      end
    end
    
  end
  
end

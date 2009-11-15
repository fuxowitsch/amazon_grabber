require 'amazon/ecs'

class AmazonGrabber
  def initialize(response_group='Large',country="de") 
    @access_key = 'add access key here' 
    @secret_key = 'add secret key here' 
    Amazon::Ecs.options = {:aWS_access_key_id => @access_key, :aWS_secret_key => @secret_key } 
    
    @response_group = response_group
    @country = country;
    @ecs = Amazon::Ecs.new
  end


=begin rdoc
  Returns an item by asin
=end
  def find_by_asin(asin="")
    @item = Amazon::Ecs.item_lookup(asin,:response_group => @response_group, :country => @country.to_sym).first_item
  end

=begin rdoc
  Returns an Array of ASINs for the given keyword
=end
  def find_asins_by_keyword(keyw,sort=:salesrank, country = :de)
    asins=Array.new

    res = Amazon::Ecs.item_search(keyw, {:response_group => 'Large', :sort => sort, :country => country.to_s})
    res.items.each do |item|
      asins << item.get('asin')
    end
    asins
  end  
  
=begin rdoc
  Returns a quick product-list of in an array of key/value pairs
=end
  def find_products_by_keyword(keyw, search_index = 'DVD', sort=:salesrank, country = :de)
    products=Array.new
    product=Hash.new

    res = Amazon::Ecs.item_search(keyw, {:response_group => 'Large,Images',  :search_index => search_index,:sort => sort, :country => country.to_s})

    res.items.each do |item|
     
      product={}
      product[:asin]          = item.get('asin') 
      product[:title]         = item.get('title') 
      product[:productgroup]  = item.get('productgroup') 
      product[:smallimage]    = item.get_hash('smallimage') if item.get_hash('smallimage')
      product[:mediumimage]    = item.get_hash('mediumimage') if item.get_hash('mediumimage')
      product[:largeimage]    = item.get_hash('largeimage') if item.get_hash('largeimage')
      
  
      products << product
    end
    products
  end
  
  
  def set_item(item)
    @item=item
  end

  def get_field(field)
    @item.get(field)  
  end
  
  def title
    @item.get('title') 
  end
  
  def product_group
    @item.get('productgroup')
  end
  
  def persons(person="author")
    a=@item.get_array(person) 
  end

  def image(size=:small)
    image=@item.get_hash('smallimage') if size == :small
    image=@item.get_hash('mediumimage') if size == :medium
    image=@item.get_hash('largeimage') if size == :large
    {} if image == nil
    image
  end
  
=begin rdoc
  The first review found is returned unescaped. 
=end
  
  def review
    review_array=Array.new
    reviews = @item/'editorialreview'
    if reviews 
      review=Amazon::Element.get_unescaped(reviews, 'content')
    end
    review
  end
  
=begin rdoc
  Returns an array of asins with similar products
=end

  def similar_products
    asins=Array.new
    
    products= @item/'similarproduct'
    if products
      products.each do |product|
        asins << Amazon::Element.get(product,'asin')
      end
    end
    asins
  end  
end


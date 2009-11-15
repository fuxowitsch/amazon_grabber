require 'rubygems'
require 'amazon/ecs'
require 'amazon_grabber'

describe AmazonGrabber do
  before(:each) do
    @grabber=AmazonGrabber.new
  end
   
  it "Should find a product and get data from asin" do
    @product=@grabber.find_by_asin("B000MGB0C4")
    @product.should_not eql(nil)
  end
  
  it "Should find asins by keyword" do
    @asins=@grabber.find_asins_by_keyword("Star Trek")
    @asins.should_not be_empty
  end
  
  it "Should find products by keyword which are fill with data" do
    @products=@grabber.find_products_by_keyword("Star Trek")
    @products.each do |p|
      p.should_not eql(nil)
    
      #p[:title].should_not be_blank
      #p[:asin].should_not be_blank
      #p[:product_group].should_not be_blank
    end
  end

 
end


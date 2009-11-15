AmazonGrabber
=============

AmazonGrabber is a wrapper class around amazon/ecs to make it a bit simpler to retrieve products from amazon. 

Please install the amazon-ecs gem first. Within the initialize method you should set your **accesskey** and your **secretkey**. Probably I am going to change this in the near future, but maybe not. 

The whole thing is not very pretty but works fine for me.

Example
-------

    require 'rubygems'
    require 'amazon_grabber'
    
    grabber=AmazonGrabber.new('Large','de')                 # Large response group and German products
    asins = grabber.find_asins_by_keyword("Universe")       # Do a search based on the keyword and return an array of asins
    grabber.find_by_asin(asins.first)                       # Get a product by Asin

    grabber.title
    grabber.product_group
    grabber.persons("author")
    grabber.image(:medium)
    grabber.review
    grabber.get_field("formattedprice")                     # Get other fields
    
    grabber.similar_products                                # Returns asin-array of similar products
    
    p=grabber.find_products_by_keyword("Twilight","DVD")    # Returns pre-parsed array of hashes for easy access
    p.each do |i|
      puts "#{i[:asin]}\t#{i[:title]}\t#{i[:product_group]}\t#{i[:mediumimage]}"
    end

Todo
----

- Currently the retrieval methods take a parameter country which is preset to :de. This has to be changed as the country is available in initalize
- we have some rspec tests, not very good ones and not many. Will improve that
- access and secretkey should be taked out of ENV or so 

License
-------
               DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                       Version 2, December 2004

    Copyright (C) 2009 Bernhard Fuchs
     Hauptstrasse 23, 83553 Frauenneuharting, Germany
    Everyone is permitted to copy and distribute verbatim or modified
    copies of this license document, and changing it is allowed as long
    as the name is changed.

               DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
      TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

     0. You just DO WHAT THE FUCK YOU WANT TO.


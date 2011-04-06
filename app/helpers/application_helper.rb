module ApplicationHelper

	#Helper method to return the logo
	def logo
		logo = image_tag("solomons_twitter_logo.png", :alt => "Sample App", :class => "round")
	end

	# Return a title on a per-page basis
	def title
		base_title = "Solomon's Twitter"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end

	


end

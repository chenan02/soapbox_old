module ApplicationHelper
	def default_title(page_title = '')
		base_title = "Soapbox Application"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end
end

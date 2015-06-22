class String 
	def to_html
 		self.gsub(/(?:\n\r?|\r\n?)/, '<br>')
 	end
end
def load_products(file)
	products = []

	CSV.foreach(file, headers: true) do |line| 
	products[line["SKU"]] = {name: line["Name"], Retail_Price: line["Retail_Price"], Purchasing_Price: line["Purchasing_Price"]}
	end
end
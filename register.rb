require 'csv'
require 'pry'
require 'date'

class Register
	attr_reader :products, :item, :invoice, :transactions
	def initialize
		@products = {}
		@invoice = {}
		@transactions = {}
		@subtotal = 0
	end

	def load_products(file)
		CSV.foreach(file, headers: true) do |line| 
  			@products[line["SKU"]] = {name: line["Name"], Retail_Price: line["Retail_Price"], Purchasing_Price: line["Purchasing_Price"]}
		end
	end

	def display_menu
		puts "Please make a selection"
		puts "Enter 1 to start a new transaction!"
		puts "Enter 2 to retrieve a daily report!"
	end

	def get_selection
		puts 'Make Your Selection!'
		@menu_selection = gets.chomp
	end

	def get_item_qty
		puts 'Enter how many!'
		@qty = gets.chomp
	end	

	def get_item
		puts 'Enter an Item!'
		@item = gets.chomp
	end

	def calculate_subtotal
		@subtotal += (@products[@item][:Retail_Price].to_f * @qty.to_f)
	end

	def add_to_invoice
		@invoice[@item] = {} if @invoice[@item].nil?
		@invoice[@item][:type] = @products[@item][:name]
		@invoice[@item][:qty] = 0 if @invoice[@item][:qty].nil?
		@invoice[@item][:qty] += @qty.to_i
	end

	def display_invoice
		puts @invoice
	end

	def get_date_time
		@date = Time.new
		@date = "#{@date.year}#{@date.month}#{@date.day}"
		@time = Time.new
		@time = "#{@time.hour}#{@time.min}#{@time.sec}"

	end

	def add_to_csv
		CSV.open("invoices.csv", "a+") do |csv|
			csv << ["Date", "Time", "SKU", "Name", "Price", "Qty"] if csv.count < 1
			@invoice.each do |key,value|
				csv << [@date, @time, key, @invoice[key][:type], @products[key][:Retail_Price], @invoice[key][:qty]]
			end
  		end
  		@invoice = {}
	end

	def load_invoices(file)
		CSV.foreach(file, headers: true) do |line|
			date = line["Date"]
			if @transactions[date].nil?
				@transactions[date] = {}
			end
			time = line["Time"]
			if @transactions[date][time].nil?
				@transactions[date][time] = []
			end
			@transactions[date][time] << [line["SKU"], line["Name"], line["Price"], line["Qty"]]
		end
	end

	def get_daily_sales(date)
		gross_sales = 0
		@transactions[date].each do |key,value|
			value.each do |index|
				
			end	
		end
	end

end
require './register.rb'
require 'pry'

cashier = Register.new

#Load Inventory List from CSV
cashier.load_products("products.csv")

#Display Menu
#cashier.display_menu

#Make Selection
#cashier.get_selection

#If start new transaction
while cashier.get_item != 'done' do
cashier.get_item_qty
cashier.calculate_subtotal
cashier.add_to_invoice
end

cashier.get_date_time
cashier.add_to_csv
cashier.load_invoices('invoices.csv')
puts cashier.transactions
cashier.get_daily_sales("20131122")




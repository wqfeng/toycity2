require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print "Sales Report" in ascii art
puts "                                                          "
puts " ____        _             ____                       _   "   
puts "/ ___|  __ _| | ___  ___  |  _ \\ ___ _ __   ___  _ __| |_ " 
puts "\\___ \\ / _` | |/ _ \\/ __| | |_) / _ \\ '_ \\ / _ \\| '__| __|"
puts " ___) | (_| | |  __/\\__ \\ |  _ <  __/ |_) | (_) | |  | |_ "
puts "|____/ \\__,_|_|\\___||___/ |_| \\_\\___| .__/ \\___/|_|   \\__|"
puts "                                    |_|                   "

# Print today's date
puts "Today's Date:" + Time.now.strftime("%d/%m/%Y")

# Print "Products" in ascii art
puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|"

# For each product in the data set:
# Print the name of the toy
# Print the retail price of the toy
# Calculate and print the total number of purchases
# Calculate and print the total amount of sales
# Calculate and print the average price the toy sold for
# Calculate and print the average discount (% or $) based off the average sales price

products_hash["items"].each do |item|
  puts item["title"]
  puts "***************************"

  full_price = Float(item['full-price'])
  total_purchases = item['purchases'].length
  total_sales = item['purchases'].map {|p| p['price']}.reduce(:+)
  average_price = total_sales / total_purchases
  discount = full_price - average_price
  discount_percentage = (discount / full_price * 100).round(2)

  puts "Retail Price: $#{full_price}"
  puts "Total Purchases: #{total_purchases}"
  puts "Total Sales: $#{total_sales}"
  puts "Average Price: $#{average_price}"
  puts "Average Discount: $#{discount}"
  puts "Average Discount Percentage: #{discount_percentage}%"

  puts "***************************"
  puts
end

# Print "Brands" in ascii art
puts " _                         _     "
puts "| |                       | |    "
puts "| |__  _ __ __ _ _ __   __| |___ "
puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
puts "| |_) | | | (_| | | | | (_| \\__ \\"
puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
puts

# For each brand in the data set:
# Print the name of the brand
# Count and print the number of the brand's toys we stock
# Calculate and print the average price of the brand's toys
# Calculate and print the total sales volume of all the brand's toys combined
products_by_brand = products_hash["items"].group_by {|item| item['brand']}
products_by_brand.each do |k, v|
  puts k
  puts "***************************"
  stock = v.map {|e| e['stock']}.reduce(:+)
  average_price = (v.map {|e| Float(e['full-price'])}.reduce(:+) / v.length).round(2)
  total_sales = v.map {|e| e['purchases'].map {|p| p['price']}.reduce(:+)}.reduce(:+).round(2)

  puts "Number of Products: #{stock}"
  puts "Average Product Price: $#{average_price}"
  puts "Total Sales: $#{total_sales}"

  puts
end

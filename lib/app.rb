require 'json'

def setup_files
  path = File.join(File.dirname(__FILE__), '../data/products.json')
  file = File.read(path)
  $products_hash = JSON.parse(file)
  $report_file = File.new("report.txt", "w+")
end

def create_report
  puts_report_header
  puts_product_header
  puts_products
  puts_brand_header
  puts_brands
  # close the file at the end.
  $report_file.close
end

def puts_report_header
  # Print "Sales Report" in ascii art
  $report_file.puts "                                                          "
  $report_file.puts " ____        _             ____                       _   "
  $report_file.puts "/ ___|  __ _| | ___  ___  |  _ \\ ___ _ __   ___  _ __| |_ "
  $report_file.puts "\\___ \\ / _` | |/ _ \\/ __| | |_) / _ \\ '_ \\ / _ \\| '__| __|"
  $report_file.puts " ___) | (_| | |  __/\\__ \\ |  _ <  __/ |_) | (_) | |  | |_ "
  $report_file.puts "|____/ \\__,_|_|\\___||___/ |_| \\_\\___| .__/ \\___/|_|   \\__|"
  $report_file.puts "                                    |_|                   "
  # Print today's date
  $report_file.puts "Today's Date:" + Time.now.strftime("%d/%m/%Y")
end

def puts_product_header
  # Print "Products" in ascii art
  $report_file.puts "                     _            _       "
  $report_file.puts "                    | |          | |      "
  $report_file.puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
  $report_file.puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
  $report_file.puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
  $report_file.puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
  $report_file.puts "| |                                       "
  $report_file.puts "|_|"
end

def puts_products
  # For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price
  $products_hash["items"].each do |item|
    $report_file.puts item["title"]
    $report_file.puts "***************************"

    full_price = Float(item['full-price'])
    total_purchases = item['purchases'].length
    total_sales = item['purchases'].map {|p| p['price']}.reduce(:+)
    average_price = total_sales / total_purchases
    discount = full_price - average_price
    discount_percentage = (discount / full_price * 100).round(2)

    $report_file.puts "Retail Price: $#{full_price}"
    $report_file.puts "Total Purchases: #{total_purchases}"
    $report_file.puts "Total Sales: $#{total_sales}"
    $report_file.puts "Average Price: $#{average_price}"
    $report_file.puts "Average Discount: $#{discount}"
    $report_file.puts "Average Discount Percentage: #{discount_percentage}%"

    $report_file.puts "***************************"
    $report_file.puts
  end
end

def puts_brand_header
  # Print "Brands" in ascii art
  $report_file.puts " _                         _     "
  $report_file.puts "| |                       | |    "
  $report_file.puts "| |__  _ __ __ _ _ __   __| |___ "
  $report_file.puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
  $report_file.puts "| |_) | | | (_| | | | | (_| \\__ \\"
  $report_file.puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
  $report_file.puts
end

def puts_brands
  # For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total sales volume of all the brand's toys combined
  products_by_brand = $products_hash["items"].group_by {|item| item['brand']}
  products_by_brand.each do |k, v|
    $report_file.puts k
    $report_file.puts "***************************"
    stock = v.map {|e| e['stock']}.reduce(:+)
    average_price = (v.map {|e| Float(e['full-price'])}.reduce(:+) / v.length).round(2)
    total_sales = v.map {|e| e['purchases'].map {|p| p['price']}.reduce(:+)}.reduce(:+).round(2)

    $report_file.puts "Number of Products: #{stock}"
    $report_file.puts "Average Product Price: $#{average_price}"
    $report_file.puts "Total Sales: $#{total_sales}"
    $report_file.puts
  end
end


def start
  setup_files
  create_report
end

start # let's the fun begin!

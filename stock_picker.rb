def stock_picker(prices)
  best_prices = [0,1]
  prices.each_with_index do |price, day|
    for next_day in day+1..prices.length-1 do
      if price < prices[next_day] && (prices[next_day] - price) > (prices[best_prices[1]] - prices[best_prices[0]])
        best_prices = [day, next_day]
      else
        next
      end
    end
  end
  p best_prices
end

stock_picker([17,3,6,9,15,8,6,1,10])
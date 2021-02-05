Oystercard Layout


Challenge 12:

Data structure (array or hash) to hold an ordered sequence of objects
  => initialize @history = Hash.new (attr_reader?)

Updates every time a journey is made.
  => Push entry_station value to array at touch_in and seperate entry_station value to hash at touch_out to signify entry & exit stations
  => ? Make this a private method and call it from touch_in & touch_out
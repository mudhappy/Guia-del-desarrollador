heroes = 
{
	:mud => 20,
	:flash => 350,
	:arrow => 200
}

puts heroes

puts heroes.collect{|key,value| value.next}



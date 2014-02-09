def startscores
	$hs_alltime = 0
	$hs_name = "trip mcneely"
	$hs_c = 0
	$hs_w = 0
end

startscores

def title
system "clear" unless system "cls"
puts "
,--.   ,--.  ,---. ,--------.,--.  ,--.    ,--.   ,--.,------.,------. 
|   `.'   | /  0   |--.  .--'|  '--'  |    |  |   |  ||  .---'|  .---' 
|  |'.'|  ||  .-.  |  |  |   |  .--.  |    |  |   |  ||  `--, |  `--,  
|  |   |  ||  | |  |  |  |   |  |  |  |.--.|  '--.|  ||  |`   |  `---. 
`--'   `--'`--' `--'  `--'   `--'  `--''--'`-----'`--'`--'    `------' "
	puts "\n\n"
	puts "push 1 to play [high score is #{$hs_alltime} set by #{$hs_name.chomp}]"
	puts "push 2 to for info"
	puts "push 3 to exit"
	difselect = gets.to_i

	if difselect == 1
		puts "cool"
		puts "\n"
	elsif difselect == 2
		puts "\nyour goal is to solve math problems for 25 seconds."
		puts "correct responses are worth 1 point"
		puts "you will lose 2 for every question you get wrong"
		puts "try to set a world record"
		puts "\npush any button to continue\n"
			continue = gets.to_i
				if continue == 0
					title
				else
					title
				end
	else
		puts "got it. thanks."
		abort
	end

	puts "a twenty five second game starts..."
	sleep rand(1..5)
	puts "now!!"
end

def timecalc
	$start = Time.now
	$finish = Time.now + 25
	$z = 1
	$all = $finish.to_i - $start.to_i
	$gametime = $finish - Time.now
end

def reroll
	$lo = rand(1..10)
	$hi = rand(70..200)
	$a = rand($lo .. $hi)
	$b = rand($lo .. $hi)
end

def math
	$function = ["+", "-", "*", "/"].sample
		if $function == "+"
			addition
		elsif $function == "-"
			subtraction
		elsif $function == "*"
			multiplication
		elsif $function == "/"
			division
		end
end

def addition
	$a = rand($lo .. $hi)
	$b = rand($lo .. $hi)
	$c = $a + $b
		until $a > $b && $c < 200
			addition
		end
	$c = $a + $b
end

def subtraction
	$a = rand($lo .. $hi)
	$b = rand($lo .. $hi)
	$c = $a - $b
		until $a > $b && $c < 200
			subtraction
		end
	$c = $a - $b
end

def multiplication
	$a = rand($lo .. $hi)
	$b = rand($lo .. $hi)
	$c = $a * $b
		until $a > $b && $c < 200
			multiplication
		end
	$c = $a * $b
end

def division
	$a = rand($lo .. $hi).round
	$b = rand($lo .. $hi).round
	$c = $a.to_f / $b
		until $a > $b and $c.to_f == $c.to_i
			division
		end
end

def response
	puts "#{$a} #{$function} #{$b}"
		$resp = gets.to_i
			if $resp == $c
				puts "yep\n"
				$hs_c += 1
				$cur_score = $hs_c - $hs_w*2
				puts "#{$hs_c} right, #{$hs_w} wrong"
				$gametime = $finish - Time.now
			elsif $resp != $c && $resp != 0001
				puts "nope\n"
				$hs_w += 1
				$cur_score = $hs_c - $hs_w*2
				puts "#{$hs_c} right, #{$hs_w} wrong"
				$gametime = $finish - Time.now
			elsif $resp == 0001
				puts "\nthanks for playing\n"
				abort
			end
end

def result
	if $cur_score > $hs_alltime 
		puts "you are now the all time points leader with a total score of #{$cur_score}"
		puts "what is your name so we can add you to the books?"
		$hs_name = gets.to_s
		$hs_alltime = $cur_score
		$hs_c = 0
		$hs_w = 0
		puts "congratulations, #{$hs_name.chomp}. a new game will begin soon"
	elsif $cur_score <= $hs_alltime
		puts "with #{$cur_score} points, you have failed to set a high score. keep going."
		puts "a new game will begin soon"
		$hs_c = 0
		$hs_w = 0
	end
	sleep 5
end

def play
		until $gametime < 0
		reroll
		math
		response
	end	
	sleep 0.5
	result
end

def repeat
	until $hs_alltime == 5000
		title
		timecalc
		play
	end
	result
end

repeat
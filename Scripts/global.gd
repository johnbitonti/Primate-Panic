extends Node
#keep track of previous scene for game over respawns
var prevscene
#dont display the warning in level 1 after a death
var alreadyClicked:= false

#keep track of best time and current time for level 1
var curr_level_1_time=0
var best_level_1_time=99999

#keep track of best time and current time for level 2
var curr_level_2_time=0
var best_level_2_time=99999

func convertDeltaToTime(time):
	var mils = fmod(time,1)*1000
	var secs = fmod(time,60)
	var mins = fmod(time,60*60) /60
	var time_passed = "%02d:%02d:%03d" % [mins,secs,mils]
	return time_passed

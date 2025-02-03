extends Node
var winningScore = 7

signal score_changed(new_score)
signal score2_changed(new2_score)

var scoreBlue = 0:
	set(value):
		if scoreBlue != value:
			scoreBlue = value
			emit_signal("score_changed", scoreBlue)
			
var scoreOrange = 0:
	set(val):
		if scoreOrange != val:
			scoreOrange = val
			emit_signal("score2_changed", scoreOrange)

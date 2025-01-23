extends Label

var previous_score_orange = -1

func _process(delta):
	if Global.scoreOrange != previous_score_orange:
		self.text = str(Global.scoreOrange)
		previous_score_orange = Global.scoreOrange

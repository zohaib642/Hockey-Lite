extends Label

var previous_score_blue = -1

func _process(delta):
	if Global.scoreBlue != previous_score_blue:
		self.text = str(Global.scoreBlue)
		previous_score_blue = Global.scoreBlue

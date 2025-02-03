extends Label

func _ready():
	Global.connect("score2_changed", self._on_score_changed)
	self.text = str(Global.scoreOrange)

func _on_score_changed(new2_score):
	self.text = str(new2_score)

extends Label

func _ready():
	Global.connect("score_changed", self._on_score_changed)
	self.text = str(Global.scoreBlue)

func _on_score_changed(new_score):
	self.text = str(new_score)

extends CanvasLayer


@onready var score_label = $Label

func _process(_delta):
	score_label.text = "O2: " + str(GameManager.score)

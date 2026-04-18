extends CanvasLayer


@onready var score_label = $Control/HBoxContainer/ScoreLabel

func _ready():
	# Set the initial score when the game starts
	update_ui(GameManager.score)
	
	# Optional: Connect to a signal if you want it to update automatically
	# GameManager.score_changed.connect(update_ui)

func _process(_delta):
	# The "Quick and Dirty" way: update every frame
	score_label.text = str(GameManager.score)

func update_ui(new_score):
	score_label.text = str(new_score)

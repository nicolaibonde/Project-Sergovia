extends Node2D


export (String) var menuMusic = ("res://Music/Hero's Urgency - Antonyski.wav")
export (String) var levelMusic = ("res://Music/Headblasters - Crystal.wav")

onready var tween_out = get_node("Tween")
export var transition_duration = 2.00
export var transition_type = 1 # TRANS_SINE

var player
var sfxPlayer1
var sfxPlayer2

var nextPlayer = 0

var punch

func _ready():
	player = AudioStreamPlayer.new()
	sfxPlayer1 = AudioStreamPlayer.new()
	sfxPlayer2 = AudioStreamPlayer.new()
	
	punch = load("res://SoundEffects/Punch.wav")
	
	
	self.add_child(player)
	self.add_child(sfxPlayer1)
	self.add_child(sfxPlayer2)
	player.stream = load(menuMusic)
	player.volume_db = -30
	player.play()
	
func playMenuTheme():
	fade_out(player)
	yield(tween_out,"tween_completed")
	player.stop()
	player.stream = load(menuMusic)
	player.volume_db = -30
	player.play()

func playLevelTheme():
	fade_out(player)
	yield(tween_out,"tween_completed")
	player.stop()
	player.stream = load(levelMusic)
	player.volume_db = -20
	player.play()

## HACK!!
func playSample(path, db):
	print(path)
	if nextPlayer == 0:
		sfxPlayer1.stop()
		sfxPlayer1.stream = load(path)
		sfxPlayer1.volume_db = db
		sfxPlayer1.play()
		nextPlayer = 1
	elif nextPlayer == 1:
		sfxPlayer2.stop()
		sfxPlayer2.stream = load(path) 
		sfxPlayer2.volume_db = db
		sfxPlayer2.play()
		nextPlayer = 0

func fade_out(stream_player):
	# tween music volume down to 0
	var start_vol = player.volume_db
	tween_out.interpolate_property(stream_player, "volume_db", start_vol, -50, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
	# when the tween ends, the music will be stopped


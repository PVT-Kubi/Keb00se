extends Control


var reddy = false
var playerPath
var npcPath
signal pingus

func _ready():
	get_viewport_rect().size
	pass
	
func buildSprites(pPath, nPath):	
	reddy = true
	playerPath = pPath
	npcPath = pPath

func pressed():
	if reddy:
		self.set_focus_mode(2)
		print(get_focus_mode())
		var parent = get_parent()
		parent.get_node("Node2D").endo()
		self.connect("pingus", parent.get_node("Player").get_node("KinematicBody2D"), "on_dix")
		emit_signal("pingus")
		#self.show_on_top()
		$PlayerSprite.texture = load(playerPath)
		$NpcSprite.texture = load(npcPath)
		var dialog = Dialogic.start("poczatek")
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
		
func dialog_listener(string):
	$PlayerSprite.texture = null
	$NpcSprite.texture = null
	self.set_focus_mode(0)
	$Timer.start()

func _on_Timer_timeout():
	emit_signal("pingus")

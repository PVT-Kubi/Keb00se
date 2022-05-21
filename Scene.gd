extends Node

var Player = preload("res://Player.tscn")


var npc = preload("res://NPC.tscn")
var p

func _ready():
	p = Player.instance()
	var n = npc.instance()
	
	n.position.x = 350
	n.position.y = 250
	add_child(n)
	add_child(p)
	

func dialogHud(playerPath, npcPath):
	var hud = preload("HudIdk.tscn")
	var h = hud.instance()
	if not get_node("Control"):
		add_child(h)
	if h.has_method("buildSprites"):
		h.buildSprites(playerPath, npcPath)
	print(get_children())
	

func _on_BatlleTimer_timeout():
	var random = RandomNumberGenerator.new()
	
	if random.randi_range(1, 120) % 2 == 0:
		get_tree().change_scene("BattleField.tscn")
		


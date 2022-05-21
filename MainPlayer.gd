extends Node2D

var hp = 500
var max_hp = 500
var caffeine = 50
var max_caffeine = 50
var expPoints = 0
var dmg =35
var limit = 0
var max_limit = max_hp / 2
var Pname
export(String, FILE, "*.json") var dialog_file
signal died

var Piotr = preload("res://Teammate.tscn")
var p


#func _ready():
#	p = Piotr.instance()
#	add_child(p)

func loadingFile(var path):
	var file = File.new()
	dialog_file = path
	if file.file_exists(dialog_file):
		file.open(dialog_file, file.READ)
		return parse_json(file.get_as_text())

func writingFile(var path, var obj):
	var file = File.new()
	dialog_file = path
	if file.file_exists(dialog_file):
		file.open(dialog_file, file.WRITE)
		file.store_line(to_json(obj))

func checked():
	$KinematicBody2D/Checked.visible = true
	
func unchecked():
	$KinematicBody2D/Checked.visible = false

func getAttacks():
	return loadingFile("res://attacks/PlayerAttacjs.json")
	
func getItems():
	return loadingFile("res://attacks/PlayerStatsAndItems.json")["items"]

func getStats():
	return {"hp": hp, "max_hp" : max_hp, "exp" : expPoints, "caf" : caffeine, "max_caf" : max_caffeine, "max_limit" : max_limit}

func getTeammates():
	return loadingFile("res://attacks/PlayerStatsAndItems.json")["teammates"]

func getInfoForProfiles():
	return ["Keb00se", loadingFile("res://attacks/PlayerStatsAndItems.json")["profileLink"], hp, max_hp, caffeine, max_caffeine, max_limit]

func getLimits():
	return loadingFile("resL//")

func _on_KinematicBody2D_clicked():
	var parent = get_parent()
	var child = parent.get_node("Control")
	if child:
	#	child.connect("pressed", child, "_on_Button_pressed")
		#emit_signal("pressed")
		child.pressed()
		
	
	
	
		
	

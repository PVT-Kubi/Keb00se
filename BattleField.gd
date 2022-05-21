extends Node

var Player = preload("res://Player.tscn")
var Enemy = preload("res://Enemy.tscn")
var hud = preload("res://AttackingMenu.tscn")
var people = {
	"enemies" : [],
	"students" : []
}
onready var size = get_viewport().size
var margins

func numberOfEnemies():
	var random = RandomNumberGenerator.new()
	var number
	random.randomize()
	number = random.randi_range(1,100)
	if number < 50 :
		return 2
	elif number > 50 and number < 75:
		return 1
	else:
		return 3


func positionEveryone():
	var y = 0
	var x = 0
	for e in people["enemies"]:
		e.position.x = margins["x"][x]
		e.position.y = margins["y"][y]
		if y == 0:
			x+=1
		y += 1

	y = 0
	x+=1
	for s in people["students"]:
		s.position.x = margins["x"][x]
		s.position.y = margins["y"][y]
		if y == 0:
			x+=1
		y += 1
		

func get_entites(var side):
	if side == 0:
		return people["enemies"]
	else:
		return people["students"]

func uncheckEveryone():
	for e in people["enemies"]:
		e.unchecked()
		
	for e in people["students"]:
		e.unchecked()
	

func setCheck(var side, var person):
	for e in people["enemies"]:
		e.unchecked()
		
	for e in people["students"]:
		e.unchecked()
	
	if side == 0:
		people["enemies"][person].checked()
	else:
		people["students"][person].checked()

func _ready():
	var y = (size.y / 8)
	var h = hud.instance()
	
	y -= y/5
	var x = size.x / 8
	margins = {"y" : [y * 4, y*2, y*6], "x" : [(x*4) - x/2, x *2, (x*4) + x/2, x*6]}
	
	for i in range(numberOfEnemies()):
		people["enemies"].append(Enemy.instance())
		add_child(people["enemies"][i])
		
	print(people["enemies"])
	
	people["students"].append(Player.instance())
	h.init(people["students"][0])
	add_child(people["students"][0])
	print(self.get_children())
	
	var team = people["students"][0].getTeammates()
	people["students"][0].get_node("KinematicBody2D").on_dix()
	
	print(team)
	if team.size() > 0:
		var teammate = load("res://Teammate.tscn")
		for i in team:
			var t = teammate.instance()
			t.loadData(i)
			people["students"].append(t)
			add_child(t)
	h.setProfiles(people["students"])
	add_child(h)
	positionEveryone()


extends KinematicBody2D


var all_info
onready var velocity = Vector2()
onready var speed
onready var playerBody = get_parent().get_node("Player").get_node("KinematicBody2D")
onready var twojStary = $AnimationTree.get("parameters/playback")

export(String, FILE, "*.json") var dialog_file

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
	$Checked.visible = true
	
func unchecked():
	$Checked.visible = false

func loadData(var path):
	all_info = loadingFile(path)

func getAttacks():
	return all_info["attacks"]
	
func getItems():
	return all_info["items"]
	
func getInfoForProfiles():
	if all_info.has("grind"):
		return [all_info["name"], all_info["profileLink"], all_info["hp"], all_info["max_hp"], all_info["grind"], all_info["max_grind"], all_info["max_limit"]]
	else:
		return [all_info["name"], all_info["profileLink"], all_info["hp"], all_info["max_hp"], all_info["caffeine"], all_info["max_caffeine"], all_info["max_limit"]]

func getLimits():
	return all_info["limits"]

func _ready():
	var playerSprite =  playerBody.get_node("Sprite")
	self.position.x = -5
	$Sprite.scale.x = playerSprite.scale.x
	$Sprite.scale.y =playerSprite.scale.y
	
#funkcja podąrzania za graczem (na razie odpuszczam bo mnie wkurwia)

#func _physics_process(delta):
#	speed = playerBody.get_speed()
#	print(str(self.position.x - playerBody.position.x) + " "+ str(self.position.y))
#
#	if int(playerBody.position.y) != int(self.position.y):
#		if self.position.x - playerBody.position.x < 0:
#			velocity.x = playerBody.get_position().y
#			velocity.y = playerBody.get_position().x
#		else:
#			velocity.x = playerBody.get_position().x
#			velocity.y = playerBody.get_position().y
#	else:
#		if playerBody.get_position().x < 0:
#			if self.position.x < playerBody.position.x:
#				playerBody.position.x = self.position.x
#		velocity.x = playerBody.get_position().x
#		velocity.y = playerBody.get_position().y
#
#
#	if velocity != Vector2.ZERO:
#		$AnimationTree.set("parameters/Idle/blend_position", velocity)
#		$AnimationTree.set("parameters/walking/blend_position", velocity)
#		twojStary.travel("walking")
#	else:
#		twojStary.travel("Idle")
#
#	velocity = move_and_slide(velocity.normalized()*speed)



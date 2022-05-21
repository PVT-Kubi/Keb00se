extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("sexoooooooooooooooooooooooooooo")

func endo():
	$Npc/AnimatedSprite.visible = false
	$Npc/AnimatedSprite.stop()


func _on_Area2D_body_entered(body):
	var parent = get_parent()
	#var playerPath = body.get_node("Sprite").texture.get_path()
	var playerPath = body.get_node("Sprite").texture.get_path()
	print(playerPath)
	if parent.has_method("dialogHud"):
		$Npc/AnimatedSprite.visible = true
		$Npc/AnimatedSprite.play()
		parent.dialogHud(playerPath, $Npc/Sprite.texture.get_path())



func _on_Npc_body_exited(body):
		$Npc/AnimatedSprite.visible = false
		$Npc/AnimatedSprite.stop()

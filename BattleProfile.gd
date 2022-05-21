extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func init(var entityStats):
	print("fsd")
	$Name.text = entityStats[0]
	$Sprite.texture = load(entityStats[1])
	$Sprite.scale = Vector2(5,5)
	#$Sprite.get_path() #= entityStats[1]
	$HpBar.max_value = entityStats[3]
	$CafBar.max_value = entityStats[5]
	$WkurwBar.max_value = entityStats[6]
	
	$HpBar.value = entityStats[2]
	$CafBar.value = entityStats[4]


func _ready():
	print("pass # Replace with function body.ss")


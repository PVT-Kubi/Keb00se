extends Node2D

export(String, FILE, "*.json") var dialog_file

var max_hp
var hp
var enemy
var effect
signal delete

var enemies = {
	"WeakCock" : [200, "Basic.tres", "WeakCock"],
	"StrongCuckold" : [500, "Essa.tres","StrongCuckold"]
}


func checked():
	$Checked.visible = true
	
func unchecked():
	$Checked.visible = false

func randomNumberTotally(var common, var uncommon):
	var random = RandomNumberGenerator.new()
	var number
	random.randomize()
	number = random.randi_range(1,10)
	if number  <= 7:
		return common
	elif number <= 10 and number > 7:
		return uncommon

func attacksShit():
	var penis = load_attack(enemy[2])
	var attack
	print("ATAKUJE")
	if hp < (hp * 40)/100:
		attack = penis[randomNumberTotally(1, 0)]
	else:
		attack = penis[randomNumberTotally(0, 1)]
		
	var damage = int(attack["dmg"])
	print(damage)
	
	if attack["heal"] > 0:
		hp += attack["heal"]
	return damage
	
func randomNumber2(var percent):
	var random = RandomNumberGenerator.new()
	var number
	random.randomize()
	number = random.randi_range(1,100)
	if number <= percent:
		return true
	elif number > percent:
		return false
	
func getDamage(var dmg):
	if typeof(dmg) == TYPE_DICTIONARY:
		hp -= dmg["dmg"]
		if dmg.has("effect"):
			effect = dmg["effect"]
			if randomNumber2(dmg["effect"][1]):
				print(dmg["effect"][0])
		hp += dmg["heal"]
	elif typeof(dmg) == TYPE_INT:
		hp -= dmg
	$AnimatedSprite/Health.value = hp
	if hp <= 0:
		self.connect("delete", self.get_parent(), "deletingEnemy")
		emit_signal("delete", self, "enemySide")
		self.queue_free()

func _ready():
	enemy = enemies[enemies.keys()[randomNumberTotally(0,1)]]
	hp = enemy[0]
	max_hp = hp
	#print(enemy)
	$AnimatedSprite.set_sprite_frames(load(enemy[1]))
	$AnimatedSprite.play("default")
	$AnimatedSprite/Health.max_value = max_hp
	$AnimatedSprite/Health.value = hp

	
func load_attack(nameOf):
	var file = File.new()
	dialog_file = "res://attacks//" + nameOf + ".json"
	if file.file_exists(dialog_file):
		file.open(dialog_file, file.READ)
		return parse_json(file.get_as_text())
	
func attack_ready():
	attacksShit()


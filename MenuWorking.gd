extends Control



var cursors = [[],[],[]]
var wichMenu = 0
var wichCursor = 0
#zastępstwo, potem będzie brał entity z battle field
var Entity
var player
var attacks
var attacking = false
var wichSide = 0

func init(var entity):
	Entity = entity
	var scnMenu = $ScnMenu
	cursors[0] = $FirstMenu.get_children()
	player = Entity
	attacks = player.getAttacks()
	createLabels(scnMenu, attacks, 1)
	createLabels(scnMenu, player.getItems(), 2)
	print(cursors)

func createLabels(parent, file, whereInCursors):
	var counter = 0
	var multiplayerr = 1
	var customArray = []
	for a in file:
		if counter > 2:
			counter = 0
			multiplayerr += 3.3
		var label = cursors[0][counter].duplicate()
		label.margin_left*=multiplayerr
		if a.has("amount"):
			var formattedString = "%d x %s"
			label.text = formattedString % [a["amount"] ,a["name"]]
		else:
			label.text = a["name"]
		label.visible = false
		counter += 1
		parent.add_child(label)
		customArray.append(label)
	cursors[whereInCursors].append_array(customArray)

func _ready():
	pass
#	var scnMenu = $ScnMenu
#	cursors[0] = $FirstMenu.get_children()
#	player = Entity.instance()
#	attacks = player.getAttacks()
#	createLabels(scnMenu, attacks, 1)
#	createLabels(scnMenu, player.getItems(), 2)
#	print(cursors)
	

func setProfiles(var entites):
	var profiles = [self.get_node("FirsProfile"), self.get_node("ScnProfile"), self.get_node("ThrProfile")]
	for i in range(entites.size()):
		profiles[i].init(entites[i].getInfoForProfiles())
		profiles[i].visible = true

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		if !attacking:
			cursors[wichMenu][wichCursor].get_children()[0].visible = false
			if wichCursor <= 0:
				wichCursor = cursors[wichMenu].size() - 1
			else:
				wichCursor -= 1
		else:
			var people = get_parent().get_entites(wichSide)
			if wichCursor >= people.size() - 1:
				wichCursor = 0
			else:
				wichCursor += 1
			get_parent().setCheck(wichSide, wichCursor)
			
	if Input.is_action_just_pressed("ui_down"):
		if !attacking:
			cursors[wichMenu][wichCursor].get_children()[0].visible = false
			if wichCursor >= cursors[wichMenu].size() - 1:
				wichCursor = 0
			else:
				wichCursor += 1
		else:
			var people = get_parent().get_entites(wichSide)
			if wichCursor <= 0:
				wichCursor = people.size() - 1
			else:
				wichCursor -= 1
			get_parent().setCheck(wichSide, wichCursor)
			
			
		
	if Input.is_action_just_pressed("ui_accept"):
		if wichMenu == 0:
			if wichCursor == 0:
				attacking = true
				get_parent().setCheck(wichSide, 0)
			if wichCursor == 1 or wichCursor == 2:
				wichMenu = wichCursor
				wichCursor = 0

	if Input.is_action_just_pressed("ui_left"):
		if attacking:
			if wichSide == 0:
				wichSide = 1
			else:
				wichSide = 0
			get_parent().setCheck(wichSide, 0)
				
	if Input.is_action_just_pressed("ui_right"):
		if attacking:
			if wichSide == 0:
				wichSide = 1
			else:
				wichSide = 0
			get_parent().setCheck(wichSide, 0)
	
	if Input.is_action_just_pressed("ui_cancel"):
		if attacking:
			attacking = false
			wichCursor = 0
			wichMenu = 0
			get_parent().uncheckEveryone()
		else:
			for n in cursors[wichMenu][wichCursor].get_children():
				n.visible = false
			if wichMenu == 1 or wichMenu == 2:
				wichCursor = wichMenu
				wichMenu = 0

	if !attacking:
		if wichMenu == 0:
			for l in $Desc.get_children():
					l.visible = false
			if wichCursor == 1:
				#uniewidocznienie wszystkich dzieic scnMenu (ma w sobie i itemy i skille)
				for l in $ScnMenu.get_children():
					l.visible = false
				#pokazanie tylko skillów
				for l in cursors[wichCursor]:
					l.visible = true
			elif wichCursor == 2:
				#uniewidocznienie wszystkich dzieci scnMenu (ma w sobie i itemy i skille)	
				for l in $ScnMenu.get_children():
					l.visible = false
				#pokazanie tylko itemów
				for l in cursors[wichCursor]:
					l.visible = true
			else:
				for l in $ScnMenu.get_children():
					l.visible = false
		else:
			for l in $Desc.get_children():
					l.visible = true
			if wichMenu == 1:
				$Desc/Name.text = attacks[wichCursor]["name"]
				$Desc/Desc.text = attacks[wichCursor]["desc"]
			elif wichMenu == 2:
				var items = player.loadingFile("res://attacks/PlayerStatsAndItems.json")["items"]
				$Desc/Name.text = items[wichCursor]["name"]
				$Desc/Desc.text = items[wichCursor]["desc"]
			
		cursors[wichMenu][wichCursor].get_children()[0].visible = true
	

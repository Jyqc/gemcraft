extends Node

var selected_gem

@export var gems_array : Array
@export var gems_dictionary : Dictionary

@onready var gem_counter : int = 1
@onready var gem_name : String

@onready var inventory = %PLAYER_INVENTORY
@onready var sockets = %PLAYER_SOCKETS
@onready var gem_panel_default = %GEM_PANEL_DEFAULT

@onready var gem_selected_theme = preload("res://themes/gem_selected.tres")
@onready var gem_unselected_theme = preload("res://themes/gem_unselected.tres")


func _on_gui_debug_add_gem_button_pressed() -> void:
	# GEM CREATION
	var new_gem_node = gem_panel_default.duplicate()
	new_gem_node.name = ("GEM_" + str(gem_counter))
	gem_counter += 1
	gems_array.append(new_gem_node.name)
	new_gem_node.gui_input.connect(Callable(self,"_on_gem_panel_gui_input").bind(new_gem_node.name))
	new_gem_node.mouse_entered.connect(Callable(self,"_on_gem_panel_default_mouse_entered").bind(new_gem_node.name))
	# ADD TO INVENTORY
	var inventory_dictionary_key = inventory.inventory_dictionary.find_key("empty")
	inventory.inventory_dictionary[inventory_dictionary_key] = new_gem_node.name
	var inventory_dictionary_path = inventory_dictionary_key.replace("GEM","PATH")
	var inventory_node = get_node(inventory.inventory_dictionary[inventory_dictionary_path])
	inventory_node.add_child(new_gem_node)
	new_gem_node.position = Vector2(0,0)
	gems_dictionary[(new_gem_node.name + "_LOCATION")] = new_gem_node.get_path()
	gems_dictionary[(new_gem_node.name + "_STRENGHT")] = 10
	gems_dictionary[(new_gem_node.name + "_DEXTERITY")] = 5
	gems_dictionary[(new_gem_node.name + "_INTELLIGENCE")] = 5

func gem_movement(target):
	if selected_gem == null :
		pass
	else:
		var gem_parent_name = selected_gem.get_parent().name
		if "SOCKET" in gem_parent_name:
			if "SOCKET_1" in gem_parent_name:
				sockets.sockets_dictionary["SOCKET_1_IS_FULL"] = false
				sockets.sockets_dictionary["SOCKET_1_GEM"] = "empty"
			elif "SOCKET_2" in gem_parent_name:
				sockets.sockets_dictionary["SOCKET_2_IS_FULL"] = false
				sockets.sockets_dictionary["SOCKET_2_GEM"] = "empty"
			elif "SOCKET_3" in gem_parent_name:
				sockets.sockets_dictionary["SOCKET_3_IS_FULL"] = false
				sockets.sockets_dictionary["SOCKET_3_GEM"] = "empty"
			elif "SOCKET_4" in gem_parent_name:
				sockets.sockets_dictionary["SOCKET_4_IS_FULL"] = false
				sockets.sockets_dictionary["SOCKET_4_GEM"] = "empty"
			elif "SOCKET_5" in gem_parent_name:
				sockets.sockets_dictionary["SOCKET_5_IS_FULL"] = false
				sockets.sockets_dictionary["SOCKET_5_GEM"] = "empty"
				
			selected_gem.get_parent().set_theme(sockets.gem_socket_empty_theme)

		elif "INVENTORY" in gem_parent_name:
			inventory.inventory_dictionary[(gem_parent_name+"_GEM")] = "empty"
			
		selected_gem.reparent(target)
		selected_gem.set_theme(gem_unselected_theme)
		selected_gem.position = Vector2(0,0)
		selected_gem.size_flags_horizontal = 1
		gems_dictionary[(selected_gem.name + "_LOCATION")] = selected_gem.get_path()
		sockets.sockets_changed()
		selected_gem = null
		
func _on_gem_panel_gui_input(event: InputEvent, extra_arg_0: String) -> void:
	var selected_gem_node = get_node(gems_dictionary[(extra_arg_0+"_LOCATION")])
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if selected_gem == null :
			pass
		else:
			selected_gem.set_theme(gem_unselected_theme)
		selected_gem_node.set_theme(gem_selected_theme)
		selected_gem = selected_gem_node
		gem_was_selected()
		
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if selected_gem == null :
			pass
		else:
			selected_gem.set_theme(gem_unselected_theme)
			gem_was_unselected()
			selected_gem = null

func gem_was_selected() -> void:
	for socket_key in sockets.sockets_dictionary.keys():
		if socket_key.contains("IS_FULL") == true:
			var socket_path = socket_key.replace("IS_FULL","PATH")
			if sockets.sockets_dictionary[socket_key] == true:
				get_node(sockets.sockets_dictionary[socket_path]).set_theme(sockets.gem_socket_full_theme)
			else:
				get_node(sockets.sockets_dictionary[socket_path]).set_theme(sockets.gem_socket_empty_theme)
	for inventory_key in inventory.inventory_dictionary.keys():
		if inventory_key.contains("GEM") == true:
			var inventory_path = inventory_key.replace("GEM","PATH")
			if inventory.inventory_dictionary[inventory_key] == "empty":
				get_node(inventory.inventory_dictionary[inventory_path]).set_theme(sockets.gem_socket_empty_theme)
			else:
				get_node(inventory.inventory_dictionary[inventory_path]).set_theme(sockets.gem_socket_full_theme)
		

func gem_was_unselected() -> void:
	for key in sockets.sockets_dictionary.keys():
		if key.contains("PATH") == true:
			get_node(sockets.sockets_dictionary[key]).set_theme(sockets.gem_socket_theme)
	for inventory_key in inventory.inventory_dictionary.keys():
		if inventory_key.contains("PATH") == true:
			get_node(inventory.inventory_dictionary[inventory_key]).set_theme(sockets.gem_socket_theme)
			




func _on_gem_panel_default_mouse_entered(extra_arg_0: String) -> void:
	print(extra_arg_0)
	pass # Replace with function body.

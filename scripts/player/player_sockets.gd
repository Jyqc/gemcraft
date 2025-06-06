extends Node

@onready var sockets_dictionary : Dictionary = {
	"SOCKET_1_PATH":"%GUI_AVATAR_SOCKET_1",
	"SOCKET_1_IS_FULL":false,
	"SOCKET_1_GEM":"empty",
	"SOCKET_2_PATH":"%GUI_AVATAR_SOCKET_2",
	"SOCKET_2_IS_FULL":false,
	"SOCKET_2_GEM":"empty",
	"SOCKET_3_PATH":"%GUI_AVATAR_SOCKET_3",
	"SOCKET_3_IS_FULL":false,
	"SOCKET_3_GEM":"empty",
	"SOCKET_4_PATH":"%GUI_AVATAR_SOCKET_4",
	"SOCKET_4_IS_FULL":false,
	"SOCKET_4_GEM":"empty",
	"SOCKET_5_PATH":"%GUI_AVATAR_SOCKET_5",
	"SOCKET_5_IS_FULL":false,
	"SOCKET_5_GEM":"empty"
	}

@onready var gems = %GEMS
@onready var stats = %PLAYER_STATS
@onready var gem_socket_theme = preload("res://themes/socket.tres")
@onready var gem_socket_full_theme = preload("res://themes/socket_full.tres")
@onready var gem_socket_empty_theme = preload("res://themes/socket_empty.tres")
	

func _on_sockets_gui_input(event: InputEvent, extra_arg_0: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if gems.selected_gem == null :
			pass
		else:
			if sockets_dictionary["SOCKET_" + str(extra_arg_0) + "_IS_FULL"] == false:
				sockets_dictionary["SOCKET_" + str(extra_arg_0) + "_IS_FULL"] = true
				sockets_dictionary["SOCKET_" + str(extra_arg_0) + "_GEM"] = gems.selected_gem.name
				gems.gem_movement(get_node(sockets_dictionary["SOCKET_" + str(extra_arg_0) + "_PATH"]))
				gems.gem_was_unselected()

func _on_sockets_mouse_entered(extra_arg_0: int) -> void:
	if sockets_dictionary["SOCKET_" + str(extra_arg_0) + "_IS_FULL"] == true:
		print("Socket "+str(extra_arg_0) +" is full")
	else:
		print("Socket "+str(extra_arg_0) +" is empty")

func sockets_changed():
	stats.strength = 0
	stats.dexterity = 0
	stats.intelligence = 0
	for socket_number in range(1,6):
		if sockets_dictionary["SOCKET_"+str(socket_number)+"_GEM"] == "empty":
			pass
		else:
			var gem_in_socket = sockets_dictionary["SOCKET_"+str(socket_number)+"_GEM"]
			print("presence socket: " + gem_in_socket)
			stats.strength += gems.gems_dictionary[gem_in_socket+"_STRENGHT"]
			stats.dexterity += gems.gems_dictionary[gem_in_socket+"_DEXTERITY"]
			stats.intelligence += gems.gems_dictionary[gem_in_socket+"_INTELLIGENCE"]
		stats.refresh_stats()
	

extends Node

var enabled:bool
@onready var stats = %PLAYER_STATS

func _ready():
	enabled = false
	%GUI_AUTOBATTLE_STATUS_VALUE.add_theme_color_override("font_color", Color.RED)


func _on_gui_toolbar_autobattle_button_pressed() -> void:
	if enabled == false:
		enabled = true
		%GUI_AUTOBATTLE_ZONE_SELECT_BUTTON.disabled = true
		%GUI_AUTOBATTLE_ZONE_LEVEL_BUTTON.disabled = true
		%GUI_AUTOBATTLE_STATUS_VALUE.add_theme_color_override("font_color", Color.GREEN)
		%GUI_AUTOBATTLE_STATUS_VALUE.text = "Enabled"
		%GUI_TOOLBAR_AUTOBATTLE_BUTTON.text = "Deactivate"
		%AUTOBATTLE_TIMER.start()
	else:
		enabled = false
		%GUI_AUTOBATTLE_ZONE_SELECT_BUTTON.disabled = false
		%GUI_AUTOBATTLE_ZONE_LEVEL_BUTTON.disabled = false
		%GUI_AUTOBATTLE_STATUS_VALUE.add_theme_color_override("font_color", Color.RED)
		%GUI_AUTOBATTLE_STATUS_VALUE.text = "Disabled"
		%GUI_TOOLBAR_AUTOBATTLE_BUTTON.text = "Activate"
		


func _on_autobattle_timer_timeout() -> void:
	print(str(stats.physical_damage) + " Damage done")
	stats.experience += int(stats.physical_damage)
	stats.refresh_experience()
	if enabled == true:
		%AUTOBATTLE_TIMER.start()

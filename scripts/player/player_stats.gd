extends Node

var level : int
var experience : int
var next_level_experience : int
var strength : int
var dexterity : int
var intelligence : int
var health : float
var maximum_health : float
var mana : float
var maximum_mana : float
var physical_damage : float
var physical_defence : float


func _ready():
	# Stats init
	# General
	experience = 1
	next_level_experience = 1000
	%GUI_AVATAR_STATS_GENERAL_EXPERIENCE_VALUE.text = (str(experience)+"/"+str(next_level_experience))
	level = 1
	%GUI_AVATAR_STATS_GENERAL_LEVEL_VALUE.text = str(level)
	strength = 0
	%GUI_AVATAR_STATS_GENERAL_STRENGTH_VALUE.text = str(strength)
	dexterity = 0
	%GUI_AVATAR_STATS_GENERAL_DEXTERITY_VALUE.text = str(dexterity)
	intelligence = 0
	%GUI_AVATAR_STATS_GENERAL_INTELLIGENCE_VALUE.text = str(intelligence)
	
	# Attack
	physical_damage = 0
	%GUI_AVATAR_STATS_ATTACK_PHYSICAL_DAMAGE_VALUE.text = str(physical_damage)
	# Defense
	physical_defence = 0
	%GUI_AVATAR_STATS_DEFENSE_PHYSICAL_DEFENSE_VALUE.text = str(physical_defence)
	
	# Toolbar
	health = 0
	maximum_health = 0
	%GUI_TOOLBAR_HEALTH_VALUE.text = (str(health)+"/"+str(maximum_health))
	mana = 0
	maximum_mana = 0
	%GUI_TOOLBAR_MANA_VALUE.text = (str(mana)+"/"+str(maximum_mana))

func refresh_stats():
		physical_damage_calculator()
		physical_defense_calculator()
		health_calculator()
		mana_calculator()
		%GUI_AVATAR_STATS_GENERAL_STRENGTH_VALUE.text = str(strength)
		%GUI_AVATAR_STATS_GENERAL_DEXTERITY_VALUE.text = str(dexterity)
		%GUI_AVATAR_STATS_GENERAL_INTELLIGENCE_VALUE.text = str(intelligence)
		%GUI_AVATAR_STATS_ATTACK_PHYSICAL_DAMAGE_VALUE.text = str(physical_damage)
		%GUI_AVATAR_STATS_DEFENSE_PHYSICAL_DEFENSE_VALUE.text = str(physical_defence)
		%GUI_TOOLBAR_HEALTH_VALUE.text = (str(health)+"/"+str(maximum_health))
		%GUI_TOOLBAR_MANA_VALUE.text = (str(mana)+"/"+str(maximum_mana))
		
func refresh_experience():
	if experience >= next_level_experience:
		level += 1
		%GUI_AVATAR_STATS_GENERAL_LEVEL_VALUE.text = str(level)
		experience -= next_level_experience
		next_level_experience = level * 1000
	%GUI_AVATAR_STATS_GENERAL_EXPERIENCE_VALUE.text = (str(experience)+"/"+str(next_level_experience))
		
func physical_damage_calculator():
	physical_damage = strength + dexterity

func physical_defense_calculator():
	physical_defence = dexterity + strength

func health_calculator():
	health = strength * 10
	maximum_health = strength * 10

func mana_calculator():
	mana = intelligence * 10
	maximum_mana = intelligence * 10
	

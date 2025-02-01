### Global.gd

extends Node

#movement states
var is_attacking = false
var is_climbing = false
var is_jumping = false

# Indicates if box can be spawned
var can_spawn = true

#current scene
var current_scene_name

#bomb movement state
var is_bomb_moving = false

#pickups
enum Pickups {HEALTH, SCORE, ATTACK}

#can the player be damaged?
var can_hurt = true

#final level results
var final_score
var final_rating
var final_time

func _ready():
	# Sets the current scene's name
	var scene_name = get_tree().get_current_scene().name
	current_scene_name = clean_scene_name(scene_name)

# Function to disable box spawning
func disable_spawning():
	can_spawn = false

# Function to enable box spawning
func enable_spawning():
	can_spawn = true

# Current level based on scene name
func get_current_level_number():
	if current_scene_name == "Main" || current_scene_name == "MainMenu":
		return 1
	elif current_scene_name.begins_with("Main_"):
		# Extract the number after "Main_"
		var level_number = current_scene_name.get_slice("_", 1).to_int()
		return level_number
	else:
		return -1 # Indicate an unknown scene
		
const SAVE_PATH ="user://savegame.save"

func save_game():
	var save_file = ConfigFile.new()
	save_file.set_value("level", "current_level", "res://Scenes/" + Global.current_scene_name + ".tscn")
	var err = save_file.save(SAVE_PATH)
	if err != OK:
		print("An error occurred while saving the game")
	else:
		print("Saving game.")
		
func load_game():
	var save_file = ConfigFile.new()
	var err = save_file.load(SAVE_PATH)
	if err == OK:
		
		var saved_level = save_file.get_value("level", "current_level", "res://Scenes/Main.tscn")
		
		var new_scene_resource = load(saved_level)
		var new_scene = new_scene_resource.instantiate()
		
		get_tree().get_root().add_child(new_scene)
		
		get_tree().current_scene = new_scene
		
		current_scene_name = get_tree().get_current_scene().name
		clean_scene_name(current_scene_name)
		
		print("Loading game.")
		
	else:
		print("An error occurred while loading the game")
		
func clean_scene_name(scene_name):
	var at_position = scene_name.find("@")
	if at_position != -1:
		return scene_name.substr(0, at_position)
	else:
		return scene_name

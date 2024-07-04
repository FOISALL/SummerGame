extends Node

const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"mana": PlayerInfo.mana,
		"health": PlayerInfo.health
	}
	print("saved mana: " + str(PlayerInfo.mana) + "and health "+  str(PlayerInfo.health))
	var jstr = JSON.stringify(data)
	file.store_line(jstr)


func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	print("test3")
	if FileAccess.file_exists(SAVE_PATH) == true:
		print("test2")
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			print("test1")
			if current_line:
				PlayerInfo.mana = current_line["mana"]
				PlayerInfo.health = current_line["health"]
				print(PlayerInfo.mana)
				print(PlayerInfo.health)
				



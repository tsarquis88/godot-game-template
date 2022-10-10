extends Node


signal ReTranslate


@onready var config = ConfigFile.new()


func _ready():
	if config.load(GameSettings.CONFIG_FILE_PATH) == OK:
		set_language(config.get_value("language", "LANGUAGE"))


func set_language(value : String) -> void:
	TranslationServer.set_locale(value)
	emit_signal("ReTranslate")
	config.set_value("language", "LANGUAGE", value)
	config.save(GameSettings.CONFIG_FILE_PATH)


func get_language() -> String:
	return TranslationServer.get_locale().substr(0, 2)

extends Node


signal ReTranslate


@onready var config = ConfigFile.new()


func _ready():
	set_language(GameSettings.getSetting("language", "LANGUAGE"))


func set_language(value : String) -> void:
	TranslationServer.set_locale(value)
	emit_signal("ReTranslate")
	GameSettings.setSetting("language", "LANGUAGE", value)


func get_language() -> String:
	return TranslationServer.get_locale().substr(0, 2)

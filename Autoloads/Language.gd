extends Node


signal ReTranslate


@onready var config = ConfigFile.new()


func _ready():
	set_language(GameSettings.getSetting("language", "LANGUAGE"))
	
	Logger.logDebug("Language autoload: Ready")


func set_language(value : String) -> void:
	TranslationServer.set_locale(value)
	emit_signal("ReTranslate")
	GameSettings.setSetting("language", "LANGUAGE", value)
	
	Logger.logDebug("Language changed to: " + value)


func get_language() -> String:
	return TranslationServer.get_locale().substr(0, 2)

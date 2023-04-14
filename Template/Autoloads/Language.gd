extends Node

signal re_translate


func _ready():
	set_language(GameSettings.get_setting("language", "LANGUAGE"))

	Logger.log_debug("Language autoload: Ready")


func set_language(value: String) -> void:
	TranslationServer.set_locale(value)
	emit_signal("re_translate")
	GameSettings.set_setting("language", "LANGUAGE", value)

	Logger.log_debug("Language changed to: " + value)


func get_language() -> String:
	return TranslationServer.get_locale().substr(0, 2)

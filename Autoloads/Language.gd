extends Node


signal ReTranslate


# TODO: Add language persistance after exiting


func set_language(value : String) -> void:
	TranslationServer.set_locale(value)
	emit_signal("ReTranslate")


func get_language() -> String:
	return TranslationServer.get_locale().substr(0, 2)

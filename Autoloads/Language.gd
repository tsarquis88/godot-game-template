extends Node


signal ReTranslate


func set_language(value : String) -> void:
	TranslationServer.set_locale(value)
	emit_signal("ReTranslate")

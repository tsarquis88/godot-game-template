extends CanvasLayer

@onready var m_text_label = find_child("TextLabel")
@onready var m_size_label = find_child("SizeLabel")
@onready var m_playable = get_parent().find_child("Playable")


# Sets up the HUD
func _ready():
	Language.connect("re_translate", self.on_re_translate)
	m_size_label.text = "1"
	on_re_translate()
	m_playable.connect("hud_update_food", self.on_hud_update_food)
	on_re_translate()


# Update labels text
func on_re_translate():
	m_text_label.text = tr("HUD-SIZE")


# Method used by the Playground node in order to set the pause. This method
# should be always implemented and it should take care of the pause mode of its
# children nodes.
func set_pause(_pause: bool):
	pass


func on_hud_update_food(snake_size: int):
	m_size_label.text = str(snake_size)

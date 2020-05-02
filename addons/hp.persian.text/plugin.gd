tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("fa", "res://addons/hp.persian.text/Persian.gd")
	pass

func _exit_tree():
	remove_autoload_singleton("fa")
	pass

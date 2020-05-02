extends Node
class_name SourceReader



var source := ''
var start := 0
var current := 0
var tokens := []

func _init(_source):
	source = _source
	start = 0
	current = 0
	tokens = []


func advance():
	
	current += 1
	
	return source[current-1]


func peek_next():
	
	if current + 1 >= source.length():
		return "\\0"
	
	return source[current + 1]


func peek():
	
	if is_at_end():
		return "\\0"
	
	return source[current]


func is_at_end():
	return current >= source.length()



func append_token(tok):
	tokens.append(tok)

func substr():
	return source.substr(start, current - start)

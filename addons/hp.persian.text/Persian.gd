"""
https://en.wikipedia.org/wiki/Persian_alphabet

letter format:
'letter': replacement

replacement format:
['isolated', 'initial', 'medial', 'final']
"""
extends Node


const BRACKETS : = [
	['(', ')'], ['«', '»'], ['{', '}'], ['[', ']'], ['<', '>']
]

const NUMBERS : = [
	'۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹',
	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
]



var source_reader_instance = load("res://addons/hp.persian.text/SourceReader.gd")
var persian_lang_instance = load("res://addons/hp.persian.text/lang/PersianLang.gd")


var reader


func fix(input: String):
	
	
	reader = source_reader_instance.new(input)
	
	scan_tokens()
	
	parsing_tokens()
	
	
	var s := ''
	for i in range(reader.tokens.size(), 0, -1):
		s += reader.tokens[i-1].body
	
	
	return s



func scan_tokens():
	
	while not reader.is_at_end():
		reader.start = reader.current
		scan_token()


func scan_token():
	
	var c = reader.advance()
	
	detect_languate(c)
	print(reader.tokens.back())



func parsing_tokens():
	
	for tok in reader.tokens:
		for lc in lclass:
			if lc.LANG_TAG == tok.lang:
				
				lc.parse(tok)



var lclass = [
	EnglishLang.new(),
	persian_lang_instance.new()
]


func detect_languate(c: String):
	
	for lc in lclass:
		if lc.isit(c):
			
			lc.lex(reader)
			return
	



class EnglishLang:
	
	var LANG_TAG = 'en'
	
	const LETTERS : = [
		'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
		'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
		'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
		'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
	]
	
	func isit(c):
		return LETTERS.find(c) != -1 
	
	
	func lex(reader):
		while (isit(reader.peek()) or isit(reader.peek_next())) and not reader.is_at_end():
		
			reader.advance()
	
	
		# Trim the surrounding quotes
		var value = reader.substr()
		
		reader.append_token({lang=LANG_TAG, body=value})
	
	func parse(token):
		pass

"""
https://en.wikipedia.org/wiki/Persian_alphabet

letter format:
'letter': replacement

replacement format:
['isolated', 'initial', 'medial', 'final']
"""
extends Node


enum {
	NOT_SUPPORTED = -1,
	ISOLATED,
	INITIAL,
	MEDIAL,
	FINAL
}


const BRACKETS : = [
	['(', ')'], ['«', '»'], ['{', '}'], ['[', ']'], ['<', '>']
]

const NUMBERS : = [
	'۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹',
	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
]



var source_reader_instance = load("res://addons/hp.persian.text/SourceReader.gd")

var reader


func fix(input: String):
	
	
	reader = source_reader_instance.new(input)
	
	scan_tokens()
	
	print(reader.tokens)
	var s := ''
	for tok in reader.tokens:
		s += tok.body
	
	return s



func scan_tokens():
	
	while not reader.is_at_end():
		reader.start = reader.current
		scan_token()


func scan_token():
	
	var c = reader.advance()
	
	detect_languate(c)





var lclass = [
	EnglishLang.new(),
	PersianLang.new()
]


func detect_languate(c: String):
	
	for lc in lclass:
		if lc.isit(c):
			
			lc.action(reader)
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
	
	
	func action(reader):
		while (isit(reader.peek()) or isit(reader.peek_next())) and not reader.is_at_end():
		
			reader.advance()
	
	
		# Trim the surrounding quotes
#		var value = reader.substr(reader.start, reader.space(reader.current))
		var value = reader.substr()
		
		reader.append_token({lang=LANG_TAG, body=value})


class PersianLang:
	
	var LANG_TAG = 'fa'
	
	const LETTERS : = {
		# alef
		'آ' : ['ﺁ', '', '', 'ﺂ'],
		'ا' : ['ﺍ', '', '', 'ﺎ'],
		# be
		'ب' : ['ﺏ', 'ﺑ', 'ﺒ', 'ﺐ'],
		# pe
		'پ' : ['ﭖ', 'ﭘ', 'ﭙ', 'ﭗ'],
		# te
		'ت' : ['ﺕ', 'ﺗ', 'ﺘ', 'ﺖ'],
		# se
		'ث' : ['ﺙ', 'ﺛ', 'ﺜ', 'ﺚ'],
		# jim
		'ج' : ['ﺝ', 'ﺟ', 'ﺠ', 'ﺞ'],
		# che
		'چ' : ['ﭺ', 'ﭼ', 'ﭽ', 'ﭻ'],
		# he jimi
		'ح' : ['ﺡ', 'ﺣ', 'ﺤ', 'ﺢ'],
		# khe
		'خ' : ['ﺥ', 'ﺧ', 'ﺨ', 'ﺦ'],
		# dal
		'د' : ['ﺩ', '', '', 'ﺪ'],
		# zal
		'ذ' : ['ﺫ', '', '', 'ﺬ'],
		# re
		'ر' : ['ﺭ', '', '', 'ﺮ'],
		# ze
		'ز' : ['ﺯ', '', '', 'ﺰ'],
		# je
		'ژ' : ['ﮊ', '', '', 'ﮋ'],
		# sin
		'س' : ['ﺱ', 'ﺳ', 'ﺴ', 'ﺲ'],
		# shin
		'ش' : ['ﺵ', 'ﺷ', 'ﺸ', 'ﺶ'],
		# sad
		'ص' : ['ﺹ', 'ﺻ', 'ﺼ', 'ﺺ'],
		# zad
		'ض' : ['ﺽ', 'ﺿ', 'ﻀ', 'ﺾ'],
		# ta
		'ط' : ['ﻁ', 'ﻃ', 'ﻄ', 'ﻂ'],
		# za
		'ظ' : ['ﻅ', 'ﻇ', 'ﻈ', 'ﻆ'],
		# ayn
		'ع' : ['ﻉ', 'ﻋ', 'ﻌ', 'ﻊ'],
		# gayn
		'غ' : ['ﻍ', 'ﻏ', 'ﻐ', 'ﻎ'],
		# fa
		'ف' : ['ﻑ', 'ﻓ', 'ﻔ', 'ﻒ'],
		# qaf
		'ق' : ['ﻕ', 'ﻗ', 'ﻘ', 'ﻖ'],
		# kaf
		'ک' : ['ﮎ', 'ﮐ', 'ﮑ', 'ﮏ'],
		# gaf
		'گ' : ['ﮒ', 'ﮔ', 'ﮕ', 'ﮓ'],
		# lam
		'ل' : ['ﻝ', 'ﻟ', 'ﻠ', 'ﻞ'],
		# la
		'ﻻ' : ['ﻻ', '', '', 'ﻼ'],
		# mim
		'م' : ['ﻡ', 'ﻣ', 'ﻤ', 'ﻢ'],
		# nun
		'ن' : ['ﻥ', 'ﻧ', 'ﻨ', 'ﻦ'],
		# vav
		'و' : ['ﻭ', '', '', 'ﻮ'],
		# he
		'ه' : ['ﻩ', 'ﻫ', 'ﻬ', 'ﻪ'],
		# ye
		'ی' : ['ﯼ', 'ﯾ', 'ﯿ', 'ﯽ'],
		# hamzeh
		'أ' : ['ﺃ', '', '', 'ﺄ'],
		'ؤ' : ['ﺅ', '', '', 'ﺆ'],
		'ئ' : ['ﺉ', 'ﺋ', 'ﺌ', 'ﺊ'],
		'ء' : ['ﺀ', '', '', ''],
	}
	
	func isit(c):
		if LETTERS.keys().find(c) != -1:
			return true 
		
		for value in LETTERS.values():
			return value.find(c) != -1
		
		return false
	
	
	func action(reader):
		while (isit(reader.peek()) or isit(reader.peek_next())) and not reader.is_at_end():
			
			reader.advance()
	
	
		# Trim the surrounding quotes
		var value = reader.substr()
	
		reader.append_token({lang=LANG_TAG, body=value})
	
	
	

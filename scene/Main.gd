extends Node


#var text : = 'لورم ایپسوم یا طرح‌نما به متنی آزمایشی و بی‌معنی در صنعت چاپ، صفحه‌آرایی و طراحی گرافیک گفته می‌شود.'
var text : = 'یک متن با دو زبان مختلف، some en word, همین.'
#var text : = 'پارسی شکر است.'


func _ready() -> void:
	
#	$Label.text = text
	$Label.text = fa.fix(text)
#	$Label2.text = fa.fix(text)
#	$Label3.text = fa.fix(text)
#	$Label4.text = fa.fix(text)
#	$Label5.text = fa.fix(text)
#	$Label2.text = fa.reverse(text)
#	$Label3.text = fa.reshaper(text, false, 0)
#	$Label4.text = fa.reverse(fa.reshape(text))
#	$Label5.text = fa.reshaper(text, true, fa.line_length($Label5))


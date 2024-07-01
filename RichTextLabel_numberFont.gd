extends RichTextLabel

var bitmapFont: BitmapFont


func _ready():
	bitmapFont = BitmapFont.new()
	bitmapFont.add_texture(preload("res://pictures/pixelfont.png"))
	bitmapFont.height = 14
	
	var startC : int = ord("0")
	var endC: int = startC+10
	
	bitmapFont.add_char(ord("0"), 0, Rect2(0, 0, 10, 14), Vector2(0,0), 12)
	bitmapFont.add_char(ord("1"), 0, Rect2(10, 0, 10, 14), Vector2(0,0), 12)
	bitmapFont.add_char(ord("2"), 0, Rect2(20, 0, 8, 14), Vector2(0,0), 10)
	bitmapFont.add_char(ord("3"), 0, Rect2(28, 0, 8, 14), Vector2(0,0), 10)
	bitmapFont.add_char(ord("4"), 0, Rect2(36, 0, 8, 14), Vector2(0,0), 10)
	bitmapFont.add_char(ord("5"), 0, Rect2(44, 0, 8, 14), Vector2(0,0), 10)
	bitmapFont.add_char(ord("6"), 0, Rect2(52, 0, 8, 14), Vector2(0,0), 10)
	bitmapFont.add_char(ord("7"), 0, Rect2(60, 0, 8, 14), Vector2(0,0), 10)
	bitmapFont.add_char(ord("8"), 0, Rect2(68, 0, 8, 14), Vector2(0,0), 10)
	bitmapFont.add_char(ord("9"), 0, Rect2(76, 0, 8, 14), Vector2(0,0), 10)
	bitmapFont.add_char(ord("$"), 0, Rect2(84, 0, 10, 14), Vector2(0,0), 12)
	
	theme = Theme.new()
	theme.default_font = bitmapFont

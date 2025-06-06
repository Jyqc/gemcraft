extends Resource
class_name gem

@export var picture : CompressedTexture2D
@export var name : String
@export var type : types
@export var level : int
@export var value : int
@export var strength : int
@export var dexterity : int
@export var intelligence : int

enum types{
	DIAMOND,
	RUBY,
	TOPAZ,
	EMERAUD,
	SAPHIR	
}

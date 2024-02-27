extends Control

@onready var property_container = %VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	
func _process(delta):
	if visible: 
		add_property("FPS", "%.2f" % (1.0/delta), 0)
	
func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible 

func add_property(title: String, value: Variant, order: int):
	var target
	target = property_container.find_child(title, true, false)
	if not target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target, order)


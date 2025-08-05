extends Area2D

#detect when a block passes over this
#replace that block with an ice block in the same location
#gray itself out maybe?
var iceBlock = preload("res://scenes/ice_block.tscn")
var blockPosition

@export var singleUse: bool = false
var hasBeenUsed = false
var usedColor: Color = Color(0.35, 0.35, 0.35, 1)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("block") and !body.is_in_group("ice_block"):
		if singleUse and hasBeenUsed:
			return
		else:
			blockPosition = body.global_position
			body.queue_free()
			var newIceBlock = iceBlock.instantiate()
			$"../NewBlocks".add_child(newIceBlock)
			newIceBlock.global_position = blockPosition
			if singleUse:
				hasBeenUsed = true
				$Sprite2D.modulate = usedColor
		

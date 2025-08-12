extends TileMapLayer




func EnableSecretWall():
	visible = true
	collision_enabled = true

func DisableSecretWall():
	visible = false
	collision_enabled = false

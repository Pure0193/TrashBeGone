extends Node2D


onready var PickupZone = $PickUpZone

func _input(event):
	if PickupZone.PlayerDetected():
		if event.is_action_pressed("Interact"):
			PlayerInventory.add_item("Snack", 1)
			WorldSoundEffect.CollectItemSound()
			queue_free()

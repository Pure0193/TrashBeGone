extends Node2D


func CollectItemSound():
	$CollectItemSound.play()

func PlayerDiedSound():
	$PlayerDied.play()

func CorrectSortSound():
	$Correct.play()

func WrongSortSound():
	$Wrong.play()

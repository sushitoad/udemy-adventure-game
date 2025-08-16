extends Marker2D

signal puzzleSolved
signal puzzleFailed

var score: int = 0
@export var scoreToSolve: int = 1


func IncreaseScore():
	score += 1
	if score >= scoreToSolve:
		puzzleSolved.emit()

func DecreaseScore():
	score -= 1
	if score < scoreToSolve:
		puzzleFailed.emit()

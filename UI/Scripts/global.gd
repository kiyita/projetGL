extends Node

signal reset_menu()

signal turnmode_change()

# Global variables

## Step turn angle in degrees
var angle : float = 20.0


# Global functions
func exit_menu():
	reset_menu.emit()

func turnmode_changing():
	turnmode_change.emit()

extends Node2D
class_name Upgrade

var graphics: UpgradeGraphics
var controller: UpgradeController
var parent: Circle

signal target_coords_changed(target_coords: Vector2i)

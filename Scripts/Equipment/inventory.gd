class_name Inventory
extends Node

var items: Array[Equipment]
var head: Equipment = Equipment.new()
var torso: Equipment = Equipment.new()
var feet: Equipment = Equipment.new()
var hands: Equipment = Equipment.new()
var weapon: Equipment = Equipment.new()
var off_hand: Equipment = Equipment.new()
var rings: Array[Equipment] = [Equipment.new(), Equipment.new()]

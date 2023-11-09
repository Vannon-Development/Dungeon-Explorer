class_name Inventory
extends Node

var items: Array[Equipment]
var head: Armor = null
var torso: Armor = null
var legs: Armor = null
var feet: Armor = null
var hands: Armor = null
var weapon: Weapon = null
var off_hand: Equipment = null
var rings: Array[Equipment] = [null, null]

func primary_damage_multiplier() -> float:
	if weapon != null: return weapon.damage
	return 1.0

func primary_attack_time() -> float:
	if weapon != null: return weapon.time
	return 1.0

func armor_reduction() -> float:
	var reduction: float = 0
	if head != null: reduction += head.reduction
	if torso != null: reduction += torso.reduction
	if feet != null: reduction += feet.reduction
	if hands != null: reduction += hands.reduction
	if legs != null: reduction += legs.reduction
	return reduction / 100.0

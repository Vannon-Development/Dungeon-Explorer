class_name Character extends Node

var character_name: String
var strength: int = 1
var dexterity: int = 1
var intelligence: int = 1
var faith: int = 1
var inventory: Inventory

func melee_damage() -> Vector2i:
	return Vector2i(strength, strength * 3) * inventory.primary_damage_multiplier()

func ranged_damage() -> Vector2i:
	return Vector2i(dexterity, dexterity * 3)

func dodge_chance() -> float:
	return dexterity / 100.0

func damage_reduction() -> float:
	return dexterity * inventory.armor_reduction()

func melee_critical_chance() -> float:
	return (strength + intelligence) / 200.0

func ranged_critical_chance() -> float:
	return (dexterity + intelligence) / 200.0

func max_life() -> int:
	return (strength + dexterity + int((intelligence + faith) / 2.0)) * 5

func max_magic() -> int:
	return (intelligence + faith) * 10

func magic_regen() -> int:
	return intelligence + faith

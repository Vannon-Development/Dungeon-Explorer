class_name Equipment
extends Node

enum Type { WEAPON, OFF_HAND, LARGE_WEAPON, HEAD, TORSO, LEGS, FEET, HANDS, RING, EMPTY }

var min_strength: int = 0
var min_dexterity: int = 0
var min_intellegence: int = 0
var min_faith: int = 0
var equip_type: Type = Type.EMPTY

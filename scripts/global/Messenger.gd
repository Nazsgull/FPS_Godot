extends Node

var player
var fish_bank
enum ToolTypes {FISHING_ROD, AK74U, CAUGHT_FISH}
enum FishTypes {SIZE_2, SALMON, COALFISH, HADDOCK}
signal LANZAMIENTO_CAÑA(id:String)
signal ADD_1_FISH(type:String)
signal REMOVE_1_FISH(type:String)
signal PAUSED
signal UNPAUSED

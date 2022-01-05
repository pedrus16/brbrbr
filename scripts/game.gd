extends Spatial

export (PackedScene) var CharacterController

onready var playersNode = $Players

var _players = {}


remotesync func del_player(id):
	playersNode.remove_child(_players[id])
	_players.erase(id)


remotesync func add_player(id):
	var character = CharacterController.instance()
	playersNode.add_child(character)
	character.name = str(id)
	_players[id] = character
	

#remote func update_player(id):
#	for id in _players:
#		_players[id].position


func _peer_connected(id):
	if not get_tree().is_network_server():
		return
	for i in _players:
		rpc_id(id, "add_player", _players[i])
	rpc("add_player", id)


func _peer_disconnected(id):
	if not get_tree().is_network_server():
		return
	rpc("del_player", id)


func _ready():
	#warning-ignore-all:return_value_discarded
	get_tree().connect("network_peer_disconnected", self, "_peer_disconnected")
	get_tree().connect("network_peer_connected", self, "_peer_connected")


#func spawn_player():
#	var playerController = CharacterController.instance()
#	add_child(playerController)

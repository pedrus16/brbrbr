extends Node

const SERVER_IP = "localhost"
const SERVER_PORT = 6060
const MAX_PLAYERS = 100

onready var peer = get_tree().get_network_peer()

func _ready():
	if not peer:
		peer = NetworkedMultiplayerENet.new()
		get_tree().network_peer = peer
	
	if get_tree().is_network_server():
		peer.create_server(SERVER_PORT, MAX_PLAYERS)
	else:
		peer.create_client(SERVER_IP, SERVER_PORT)

extends WindowDialog

signal joined
signal hosting

const DEF_PORT = 16789
const PROTO_NAME = "ludus"

onready var _host_edit = $VBoxContainer/HBoxContainer/HostEdit

var peer = null


func _close_network():
	if get_tree().is_connected("server_disconnected", self, "_close_network"):
		get_tree().disconnect("server_disconnected", self, "_close_network")
	if get_tree().is_connected("connection_failed", self, "_close_network"):
		get_tree().disconnect("connection_failed", self, "_close_network")
	if get_tree().is_connected("connected_to_server", self, "_connected"):
		get_tree().disconnect("connected_to_server", self, "_connected")
	get_tree().set_network_peer(null)
	

func _joined():
	hide()
	emit_signal("joined")


func _hosting():
	hide()
	emit_signal("hosting")


func _on_ConnectButton_pressed():
	peer = WebSocketClient.new()
	peer.connect_to_url("ws://" + _host_edit.text + ":" + str(DEF_PORT), PoolStringArray([PROTO_NAME]), true)
	#warning-ignore-all:return_value_discarded
	get_tree().connect("connection_failed", self, "_close_network")
	get_tree().connect("connected_to_server", self, "_connected")
	get_tree().set_network_peer(peer)
	_joined()


func _on_HostButton_pressed():
	peer = WebSocketServer.new()
	peer.listen(DEF_PORT, PoolStringArray(["ludus"]), true)
	get_tree().connect("server_disconnected", self, "_close_network")
	get_tree().set_network_peer(peer)
	_hosting()

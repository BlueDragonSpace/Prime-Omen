extends Control


@onready var audio_stream_player: AudioStreamPlayer = $OldSystem
@onready var new_sound_system: Node = $NewSoundSystem
@onready var c_4: AudioStreamPlayer = %C4 # the middle most note and the most important one
@onready var empty_note: AudioStreamPlayer = $EmptyNote # error-case if the notes go too high or too low than I have notes in storage

const AUDIO_BUS = preload("uid://b5mkten2d10uv")

var pitches = [0,-1,-1,-2,-1,-2,-2,-3,-3,0,-2,0,0,-2,-2,0,1,-1,1,0,-3,-1,-2,0,3,2,-1,-2,-5,-6,3,2,3,0,5,1,2,3,1,2,2,-1,3,0,-2,-5,1,7,6,2,0,0,-4,0,1,1,1,-3,-3,-5,]
#var pitches = [0, -1, 1, -2, 2, -3, 3, -4, 4, -5, 5, -6, 6, -7, 7, -8, 8, -9, 9, 30, 30, 30, 1, 2, 3]
var beat_count = 1

# defined once later
var c4_position : int

func _ready() -> void:
	
	c4_position = c_4.get_index()
	
	# begins the song
	if pitches[0] == 0:
		c_4.play()
	else:
		print('never included a case for this, assumed every song would start with c4 :P')


func _on_audio_stream_player_finished() -> void:
	
	# changes the effect of the PitchShift according to the given array values
	# in better code, should have to check that it's PitchShift first to avoid an error, but this is lazy lol
	
	# will always evaluate to false currently, got overhauled
	if beat_count + 1 < pitches.size() and false:
		
		beat_count += 1
		
		var effect = AudioServer.get_bus_effect(0, 0)
		print(str(effect))
		effect.pitch_scale = pow(2, pitches[beat_count] / 32.0)
		audio_stream_player.play()
	
	if beat_count < pitches.size():
		
		# need to find the position of the note relative to where it belongs in the NewSoundSystem, when compared to C4 being 0
		var note_position = pitches[beat_count] + c4_position
		
		
		if note_position > new_sound_system.get_child_count() - 1 or note_position < 0:
			# note is out of bounds, play empty_note and just go to the next one
			empty_note.play()
		else:
			var note = new_sound_system.get_child(note_position)
			note.play()
		
		beat_count += 1
	else:
		
		# actually no just close the program lol
		get_tree().quit()
		
		# reset the loop
		
		beat_count = 1
		empty_note.play()

extends Control


@onready var audio_stream_player: AudioStreamPlayer = $OldSystem
@onready var new_sound_system: Node = $NewSoundSystem
@onready var c_4: AudioStreamPlayer = %C4 # the middle most note and the most important one
@onready var empty_note: AudioStreamPlayer = $EmptyNote # error-case if the notes go too high or too low than I have notes in storage
@onready var background: TextureRect = $Background
@onready var loop: CheckBox = $VBoxContainer/HBoxContainer/Loop
@onready var progress: ProgressBar = $VBoxContainer/HBoxContainer3/Progress

@onready var piano_box: VBoxContainer = $HBoxContainer/VBoxContainer2/PianoBox
const PIANO_NOTE = preload("uid://4d83v8sjt701")

const AUDIO_BUS = preload("uid://b5mkten2d10uv")

# da songs
var sixty_note = [0,-1,-1,-2,-1,-2,-2,-3,-3,0,-2,0,0,-2,-2,0,1,-1,1,0,-3,-1,-2,0,3,2,-1,-2,-5,-6,3,2,3,0,5,1,2,3,1,2,2,-1,3,0,-2,-5,1,7,6,2,0,0,-4,0,1,1,1,-3,-3,-5,]
var three_hundred_note = [0,-2,-3,-5,-4,-6,-6,-7,-7,-5,-8,-6,-6,-8,-9,-7,-6,-8,-7,-8,-10,-9,-10,-9,-6,-6,-9,-10,-13,-14,-5,-7,-6,-9,-4,-7,-6,-6,-7,-6,-6,-9,-4,-8,-9,-13,-6,0,-1,-5,-7,-6,-10,-5,-5,-5,-4,-8,-8,-10,-13,-9,-1,-3,-7,-9,0,0,4,0,-2,-2,0,0,0,-2,-2,0,-2,0,4,-1,3,-1,-1,-3,-3,-2,-4,-8,-10,-4,-3,-5,-3,-6,-6,0,-5,7,7,10,10,10,5,5,8,8,7,3,3,2,0,-5,1,4,-1,-3,-4,-4,-9,-3,-6,-7,-5,-2,-1,3,4,3,3,0,1,1,-2,-1,-4,4,7,12,7,11,6,3,-2,1,9,6,1,-2,5,2,-3,-6,8,5,6,9,10,7,6,5,12,9,8,7,8,7,12,9,8,3,6,1,0,3,-2,1,-5,-6,5,2,-3,-6,-7,-8,-8,-9,-10,5,0,3,3,6,5,4,4,9,6,5,3,-2,-3,2,4,15,10,7,5,0,-1,-5,-10,-13,-9,-14,-15,11,10,8,9,20,22,29,25,20,17,15,16,12,7,5,10,12,7,3,-2,-6,-7,-3,2,2,7,5,2,0,1,-3,-2,-6,1,-3,-5,-10,-14,-15,-21,-23,-20,-8,-9,-13,-19,-2,-6,-12,-9,-5,-11,-8,-8,-10,-11,-13,-3,-4,-8,-14,-10,-7,-3,-3,5,12,10,6,0,-3,-9,-7,-3,-4,-6,4,-2,6,1,15,13,13]
var songs = [sixty_note, three_hundred_note]

# specific song used
var pitches = songs[0]

var beat_count = 1
var playing = false

# defined once later
var c4_position : int

func _ready() -> void:
	c4_position = c_4.get_index()
	
	# adds piano notes
	for i in range(new_sound_system.get_child_count()):
		var child = PIANO_NOTE.instantiate()
		child.modulate.h = 0.5
		piano_box.add_child(child)

func _process(delta: float) -> void:
	background.texture.noise.offset.x += 5 * delta
	background.texture.noise.offset.y += 5 * delta
	background.texture.noise.offset.z += 15 * delta

func start_song() -> void:
	beat_count = 0
	
	# begins the song
	empty_note.play()

func _on_audio_stream_player_finished() -> void:
	
	if playing:
		if beat_count < pitches.size():
			
			# need to find the position of the note relative to where it belongs in the NewSoundSystem, when compared to C4 being 0
			var note_position = pitches[beat_count] + c4_position
			
			
			if note_position > new_sound_system.get_child_count() - 1 or note_position < 0:
				# note is out of bounds, play empty_note and just go to the next one
				empty_note.play()
			else:
				# plays the note
				var note = new_sound_system.get_child(note_position)
				note.play()
				
				# add a thing to the piano visual
				var piano_note = piano_box.get_child(note_position)
				piano_note.add_particle()
				
				# update progress bar
				progress.value = float(beat_count) / float(pitches.size() - 1)
				
			
			beat_count += 1
		elif loop.button_pressed:
				start_song()
		else:
			playing = false


func _on_start_pressed() -> void:
	playing = true
	start_song()

func _on_stop_pressed() -> void:
	playing = false

func _on_empty_note_finished() -> void:
	print('empty note played')

func _on_song_list_item_selected(index: int) -> void:
	playing = false
	beat_count = 0
	
	pitches = songs[index]

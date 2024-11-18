extends AudioStreamPlayer

const game_music = preload("res://Music/Musica de fondo.wav")

func _play_music(music: AudioStream, volume: float = -12.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume 
	play()

func play_music_game():
	_play_music(game_music)

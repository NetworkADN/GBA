extends AudioStreamPlayer

const crowd_sfx = preload("res://SFX/murmur_on_ferry_2-31795.wav")

func _play_crowd_sfx(music: AudioStream, volume: float = -12.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume 
	play()

func play_crowd_sfx():
	_play_crowd_sfx(crowd_sfx)

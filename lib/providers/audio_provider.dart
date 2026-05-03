import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/sound_item.dart';

class AudioProvider extends ChangeNotifier with WidgetsBindingObserver{
  final AudioPlayer _audioPlayer = AudioPlayer();
  SoundItem? _currentSound;
  bool _isPlaying = false;
  bool _wasPlayingBeforePause = false;

  SoundItem? get currentSound => _currentSound;
  bool get isPlaying => _isPlaying;

  AudioProvider() {
    //зацикливание
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Приложение свернуто
      if (_isPlaying) {
        _wasPlayingBeforePause = true;
        pauseSound();
      }
    } else if (state == AppLifecycleState.resumed) {
      // Приложение активно
      if (_wasPlayingBeforePause) {
        resumeSound();
        _wasPlayingBeforePause = false;
      }
    }
  }

  void pauseSound() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resumeSound() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void toggleSound(SoundItem sound) async {
    if (_currentSound?.name == sound.name && _isPlaying) {
      await _audioPlayer.pause();
      _isPlaying = false;
    } else if (_currentSound?.name == sound.name && !_isPlaying) {
      await _audioPlayer.resume();
      _isPlaying = true;
    } else {
      await _audioPlayer.stop();
      _currentSound = sound;
      await _audioPlayer.play(AssetSource(sound.assetPath));
      _isPlaying = true;
    }
    notifyListeners(); 
  }

  void stopAll() async {
    await _audioPlayer.stop();
    _currentSound = null;
    _isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    super.dispose();
  }
}
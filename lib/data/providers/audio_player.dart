import 'dart:developer';
import 'package:just_audio/just_audio.dart';

class AudioPlayerClass {
  final player = AudioPlayer();

  Future<void> playAudio(String audioPath) async {
    try {
      if (audioPath.startsWith("http")) {
        await player.setUrl(audioPath);
        await player.play();
      } else {
        await player.setAsset(audioPath);
        await player.play();
      }
      log("Audio Path =====  $audioPath");
    } catch (t) {
      log('Error playing audio: $t');
    }
  }

  void dispose() {
    player.dispose();
    player.dispose();
  }
}

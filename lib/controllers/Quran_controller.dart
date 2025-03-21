import 'package:al_khair/Model/quran_model.dart';
import 'package:get/get.dart'; // GetX dependency
import 'package:just_audio/just_audio.dart';

class SurahController extends GetxController {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  int currentAyahIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }

  void playAyahs(Surah surah) async {
    if (isPlaying) {
      await _audioPlayer.stop();
      update(); // Update the UI
      isPlaying = false;
      currentAyahIndex = 0; // Reset to the first Ayah
    } else {
      try {
        await _playAyah(surah, currentAyahIndex);
      } catch (e) {
        print("Error playing audio: $e");
      }
    }
  }

  Future<void> _playAyah(Surah surah, int index) async {
    if (index < surah.ayahs.length) {
      final audioUrl = surah.ayahs[index].audio;
      try {
        await _audioPlayer.setUrl(audioUrl);
        await _audioPlayer.play();
        isPlaying = true;
        currentAyahIndex = index + 1;
        update(); 

        _audioPlayer.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed) {
            if (currentAyahIndex < surah.ayahs.length) {
              _playAyah(surah, currentAyahIndex);
            } else {
              isPlaying = false;
              currentAyahIndex = 0;
              update(); 
            }
          }
        });
      } catch (e) {
        print("Error loading or playing audio: $e");
      }
    }
  }

  void pauseAudio() async {
    await _audioPlayer.pause();
    isPlaying = false;
    update(); 
  }
}

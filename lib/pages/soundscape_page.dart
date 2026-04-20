import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mood_app/models/sound_item.dart';
import 'package:mood_app/services/audio_provider.dart';

class SoundscapePage extends StatelessWidget {
  const SoundscapePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final audioProvider = Provider.of<AudioProvider>(context);
    final double bottomInset = audioProvider.currentSound != null ? 100.0 : 16.0;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Soundscape", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          GridView.builder(
            padding: EdgeInsets.only(
            left: 16, 
            right: 16, 
            top: 16, 
            bottom: bottomInset
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.75,
            ),
           
            itemCount: sounds.length, 
            itemBuilder: (context, index) {
              final sound = sounds[index];
            
              bool isActive = audioProvider.currentSound?.name == sound.name && audioProvider.isPlaying;

              return _buildSoundCard(context, sound, isActive, audioProvider);
            },
          ),
          
          
          if (audioProvider.currentSound != null) 
            _buildLocalMiniPlayer(context, audioProvider),
        ],
      ),
    );
  }

  // виджет карточки звука
 Widget _buildSoundCard(BuildContext context, SoundItem sound, bool isActive, AudioProvider provider) {
  return GestureDetector(
    onTap: () => provider.toggleSound(sound),
    child: Column(
      mainAxisSize: MainAxisSize.min, 
      children: [
        
        AspectRatio(
          aspectRatio: 1, 
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(sound.imagePath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.black45 : Colors.black12,
                  BlendMode.darken,
                ),
              ),
              border: isActive 
                  ? Border.all(color: Theme.of(context).colorScheme.primary, width: 3) 
                  : Border.all(color: Colors.transparent, width: 3),
            ),
            child: Center(
              child: Icon(
                isActive ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 35,
              ),
            ),
          ),
        ),

        const SizedBox(height: 6), 

        // текст с защитой от переполнения
        Text(
          sound.name,
          textAlign: TextAlign.center,
          maxLines: 1, 
          overflow: TextOverflow.ellipsis, 
          style: TextStyle(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Theme.of(context).colorScheme.primary : Colors.black87,
          ),
        ),
      ],
    ),
  );
}

  // мини плеер
  Widget _buildLocalMiniPlayer(BuildContext context, AudioProvider provider) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: SafeArea( // Чтобы плеер не перекрывался полоской "домой" на экране
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          // Цвет чуть плотнее для читаемости
          color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), 
              blurRadius: 15, 
              offset: const Offset(0, 5)
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max, // Растягиваем на всю доступную ширину
          children: [
            // Мини-иконка текущего звука
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                provider.currentSound!.imagePath,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // Название звука
            Expanded(
              child: Text(
                provider.currentSound!.name,
                style: const TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Кнопки управления
            IconButton(
              icon: Icon(
                provider.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => provider.toggleSound(provider.currentSound!),
            ),
            IconButton(
              icon: const Icon(Icons.close_rounded, color: Colors.white70, size: 20),
              onPressed: () => provider.stopAll(),
            ),
          ],
        ),
      ),
    ),
  );
}
}
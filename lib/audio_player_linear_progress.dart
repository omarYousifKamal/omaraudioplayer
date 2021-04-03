import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

//part 2
class AudioPlayerLinearProgress extends StatefulWidget {
  @override
  _AudioPlayerLinearProgressState createState() =>
      _AudioPlayerLinearProgressState();
}

class _AudioPlayerLinearProgressState extends State<AudioPlayerLinearProgress> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  @override
  @override
  void initState() {
    super.initState();
    setupPlaylist();
  }

  void setupPlaylist() async {
    audioPlayer.open(
        Playlist(
          audios: [
            Audio(
              'assets/allthat.mp3',
              metas: Metas(
                title: 'حبنا الاكبر',
                artist: 'قيس هشام و احمد المصلاوي',
              ),
            ),
          ],
        ),
        autoStart: false,
        loopMode: LoopMode.playlist);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Widget audioPlayerUI(RealtimePlayingInfos realtimePlayingInfos) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          realtimePlayingInfos.current.audio.audio.metas.title,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          realtimePlayingInfos.current.audio.audio.metas.artist,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getTimeText(realtimePlayingInfos.currentPosition),
            linearProgressBar(realtimePlayingInfos.currentPosition,
                realtimePlayingInfos.duration),
            getTimeText(realtimePlayingInfos.duration),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(realtimePlayingInfos.isPlaying
                  ? Icons.pause_circle_outline_rounded
                  : Icons.play_circle_fill_rounded),
              onPressed: () => audioPlayer.playOrPause(),
              iconSize: 60,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }

  Widget linearProgressBar(Duration currentPosition, Duration duration) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: LinearPercentIndicator(
        width: 0.4 * MediaQuery.of(context).size.width,
        backgroundColor: Colors.grey,
        percent: currentPosition.inSeconds / duration.inSeconds,
        progressColor: Colors.white,
      ),
    );
  }

  Widget getTimeText(Duration seconds) {
    return Text(
      transformString(seconds.inSeconds),
      style: TextStyle(color: Colors.white),
    );
  }

  String transformString(int seconds) {
    String minuteString =
        '${(seconds / 120).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 10 < 10 ? 0 : ''}${seconds % 10}';
    return '$minuteString:$secondString';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/allthat.jpg'), fit: BoxFit.cover)),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
          child: audioPlayer.builderRealtimePlayingInfos(
              builder: (context, realtimePlayingInfos) {
            if (realtimePlayingInfos != null) {
              return audioPlayerUI(realtimePlayingInfos);
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}

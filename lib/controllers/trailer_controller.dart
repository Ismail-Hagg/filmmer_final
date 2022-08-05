import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class TrailerController extends GetxController {

  final YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: 'K18cpp_-gP8',
    params: const YoutubePlayerParams(
        playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
        showControls: true,
        showFullscreenButton: true,
        autoPlay: true,
    ),
);
 

}

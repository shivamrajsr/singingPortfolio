import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShivRaj',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0B10),
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Sans',
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E2DE2),
          brightness: Brightness.dark,
        ),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

enum MediaType { image, video }

class MediaItem {
  const MediaItem({required this.url, required this.type, this.caption});

  final String url;
  final MediaType type;
  final String? caption;
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  // void showContactDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Center(
  //                 child: Text(
  //                   "Contact & Booking Details",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               SizedBox(height: 20),
  //
  //               // Phone
  //               Row(
  //                 children: [
  //                   Icon(Icons.phone, color: Colors.blue),
  //                   SizedBox(width: 10),
  //                   Text(
  //                     "+91 98765 43210", // your phone number
  //                     style: TextStyle(fontSize: 16),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 12),
  //
  //               // Email
  //               Row(
  //                 children: [
  //                   Icon(Icons.email, color: Colors.red),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     child: Text(
  //                       "shivam.music.booking@gmail.com", // your email
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 12),
  //
  //               // Instagram
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Icon(Icons.camera_alt_outlined, color: Colors.purple),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     child: Text(
  //                       "Instagram: @shivraj.music",
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 12),
  //
  //               // YouTube
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Icon(Icons.play_circle_fill, color: Colors.redAccent),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     child: Text(
  //                       "YouTube: youtube.com/@shivrajmusic",
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 12),
  //
  //               // Artist Management
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Icon(Icons.person, color: Colors.green),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     child: Text(
  //                       "Artist Management: XYZ Talent Agency\nContact: +91 91234 56789",
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //
  //               SizedBox(height: 20),
  //
  //               // Close Button
  //               Align(
  //                 alignment: Alignment.centerRight,
  //                 child: ElevatedButton(
  //                   onPressed: () => Navigator.pop(context),
  //                   child: Text("Close"),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //}

  final List<MediaItem> _mediaItems = const [
    MediaItem(
      url: 'images/rockstar1.jpg',
      type: MediaType.image,
      caption: 'Phir se ud chala',
    ),
    MediaItem(
      url: 'images/Rockstar_1.jpg',
      type: MediaType.image,
      caption: 'Rockstar vibes',
    ),
    // MediaItem(
    //   url:
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //   type: MediaType.video,
    //   caption: 'Performance highlight reel',
    // ),
    // MediaItem(
    //   url:
    //       'https://images.unsplash.com/photo-1515165562835-c3b8c8e02b5e?auto=format&fit=crop&w=1400&q=80',
    //   type: MediaType.image,
    //   caption: 'Backstage moments',
    // ),
  ];

  final Map<String, VideoPlayerController> _videoControllers = {};
  final Map<String, Future<void>> _initFutures = {};

  @override
  void initState() {
    super.initState();
    for (final item in _mediaItems.where((m) => m.type == MediaType.video)) {
      _createVideoController(item.url);
    }
  }

  void _createVideoController(String url) {
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _videoControllers[url] = controller;
    _initFutures[url] = controller.initialize().then((_) {
      controller
        ..setLooping(true)
        ..setVolume(5)
        ..play();
    });
  }

  @override
  void dispose() {
    for (final controller in _videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0F1621), Color(0xFF11111A)],
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: Center(
              child: Text(
                'ShivRaj',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 500 ? 60 : 300,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 6,
                  color: Colors.white.withOpacity(0.07),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 500,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ShivRajMusic',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: MediaQuery.of(context).size.width < 500
                          ? 50
                          : 100,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Text(
                      'Singer, songwriter, performer, and storyteller. I am a versatile singer singing bollywood,'
                      'western, ghazals, pop , indie genres blending semi classical roots with modern stage energy, creating moments that feel intimate no matter the crowd size.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.6),
                        height: 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildCarousel(context),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        Center(
                          child: Text(
                            "Contact & Booking Details",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 50),

                        // Phone
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.white.withOpacity(0.6)),
                            SizedBox(width: 10),
                            Text(
                              "+91 9838509828", // your phone number
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        // Email
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.white.withOpacity(0.6)),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "shivam703368@gmail.com", // your email
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        // Instagram
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.camera_alt_outlined, color: Colors.white.withOpacity(0.6)),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Instagram: @shivamrajsr",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        // YouTube
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.play_circle_fill, color: Colors.white.withOpacity(0.6)),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "YouTube: youtube.com/@shivamrajsrmusic",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        // Artist Management
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.person, color: Colors.white.withOpacity(0.6)),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Artist Management: XYZ Talent Agency\nContact: +91 9838509828",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Close Button

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.6;

    return CarouselSlider.builder(
      itemCount: _mediaItems.length,
      options: CarouselOptions(
        height: height * 1.3,
        viewportFraction: 0.9,
        enlargeCenterPage: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enableInfiniteScroll: true,
      ),
      itemBuilder: (context, index, realIndex) {
        final item = _mediaItems[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1B1B2F), Color(0xFF11111A)],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: item.type == MediaType.image
                    ? _buildImage(item.url)
                    : _buildVideo(item.url),
              ),
              if (item.caption != null)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.15)),
                    ),
                    child: Text(
                      item.caption!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage(String url) {
    return Image.network(
      url,
      fit: BoxFit.fitHeight,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) => const Center(
        child: Icon(Icons.broken_image, size: 48, color: Colors.white54),
      ),
    );
  }

  Widget _buildVideo(String url) {
    final controller = _videoControllers[url];
    final future = _initFutures[url];

    if (controller == null || future == null) {
      return const Center(child: Icon(Icons.videocam_off, size: 48));
    }

    return FutureBuilder<void>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            controller.value.isInitialized) {
          return AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

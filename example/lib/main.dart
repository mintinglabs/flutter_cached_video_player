import 'package:flutter/material.dart';
import 'package:cached_video_player/cached_video_player.dart';

// 2.5 MB
// const String _kDataSource =
//     'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4';
// 158 MB
// const String _kDataSource =
//     'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
// from Local Assets
const String _kDataSource = 'videos/wine.mp4';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CachedVideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = CachedVideoPlayerController.asset(_kDataSource);
    // controller = CachedVideoPlayerController.network(_kDataSource);
    controller
      ..initialize()
      ..play()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CachedVideoPlayerValue playValue = controller.value;
    final StringBuffer buffer = StringBuffer()
      ..writeln('isInitialized: ${playValue.isInitialized}')
      ..writeln('isPlaying: ${playValue.isPlaying}')
      ..writeln('isBuffering: ${playValue.isBuffering}')
      ..writeln('buffered: ${playValue.buffered}')
      ..writeln('position: ${playValue.position}')
      ..write('duration: ${playValue.duration}');

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.black,
                child: CachedVideoPlayer(controller),
              ),
            ),
            Slider(
              value: playValue.duration > Duration.zero
                  ? playValue.position.inMilliseconds /
                      playValue.duration.inMilliseconds
                  : 0,
              onChanged: (double newValue) {
                final Duration position = playValue.duration * newValue;
                controller.seekTo(position);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                buffer.toString(),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapFAB,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapFAB() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const MyHomePage(title: 'Flutter Demo Home Page');
    }));
  }
}

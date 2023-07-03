import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
const riveFile = 'assets/loading2.riv';

class RiveAnimation extends StatefulWidget {
  const RiveAnimation({Key? key}) : super(key: key);

  @override
  _RiveAnimationState createState() => _RiveAnimationState();
}

class _RiveAnimationState extends State<RiveAnimation> {
    bool darkTheme = false;
  Artboard? _artboard;
  late RiveAnimationController _animationController;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFile);
    RiveFile rFile = RiveFile.import(bytes);

    setState(() => _artboard = rFile.mainArtboard
      ..addController(
        darkTheme
            ? _animationController = SimpleAnimation('dark')
            : _animationController = SimpleAnimation('light'),
      ));
  }

  void _onSucess() {
    _artboard!.artboard.removeController(_animationController);
    _artboard!.addController(darkTheme
        ? SimpleAnimation('dark_tick')
        : SimpleAnimation('light_tick'));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme ? null : Colors.blue,
      body: Center(
        child: _artboard != null
            ? Rive(
                artboard: _artboard!,
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: _onSucess,
      ),
    );
  }
}
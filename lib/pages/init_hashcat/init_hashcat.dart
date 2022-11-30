import 'package:flutter/material.dart';
import 'package:hashcat_dart/hashcat.dart';
import 'package:hashcat_flutter/components/ascii_animation.dart';
import 'package:hashcat_flutter/providers/hashcat.dart';
import 'package:provider/provider.dart';

import '../home_page/home_page.dart';

class InitHashcat extends StatefulWidget {
  const InitHashcat({Key? key}) : super(key: key);

  @override
  State<InitHashcat> createState() => _InitHashcatState();
}

class _InitHashcatState extends State<InitHashcat> with SingleTickerProviderStateMixin {
  String infoText = 'Initializing Hashcat';

  late final AnimationController _controller;
  late final Animation<double> _animation;

  init() async {
    try {
      await Provider.of<HashcatProvider>(context, listen: false).initHashcat();

      infoText = 'Hashcat Initialized!';
    } on HashcatPlatformNotSupported catch (e) {
      infoText = 'Your platform is not supported\n${e.message}';
      debugPrint(e.toString());
    } on HashcatLibLoadFailed catch (e) {
      infoText = 'Unable to load Hashcat library\n${e.message}';
      debugPrint(e.toString());
    } on HashcatDirectoryError catch (e) {
      infoText = 'Unable setup directory\n${e.message}';
      debugPrint(e.toString());
    } catch (e) {
      infoText = 'An unknown error occurred\n$e';
      debugPrint(e.toString());
    } finally {
      setState(() {});
      _controller.forward();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addListener(() => setState(() {}));
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<HashcatProvider>(context).initialized ? const HomePage() : Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AsciiAnimation.numbers(
            length: 10000,
            speed: const Duration(milliseconds: 500),
            style: TextStyle(
              fontSize: 16,
              color: ColorTween(
                begin: Colors.yellow,
                end: Provider.of<HashcatProvider>(context).initError ? Colors.red : Colors.green.shade800,
              ).evaluate(_animation),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

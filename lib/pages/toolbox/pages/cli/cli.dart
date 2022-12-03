import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashcat_flutter/providers/hashcat.dart';
import 'package:provider/provider.dart';

class CliArgs {
  /// Used to pass a command to run right away in the CLI
  final String runCommand;

  CliArgs(this.runCommand);
}

class Cli extends StatefulWidget {
  static String routeName = 'cli';

  const Cli({Key? key}) : super(key: key);

  @override
  State<Cli> createState() => _CliState();
}

class _CliState extends State<Cli> {
  final TextEditingController _textEditingController = TextEditingController(text: 'hashcat --help');
  final ScrollController _scrollController = ScrollController();
  final FocusNode _cliInputNode = FocusNode();
  final List<String> hashcatCommands = [];
  CliArgs? _args;
  CliArgs? get args => _args;
  set args(args) {
    // Only set args if it hasn't been set yet
    if (_args != null) return;
    if (args == null) return;

    _args = args;

    if (args.runCommand != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => submit(args.runCommand));
    }
  }
  int hashcatCommandPosition = 0;
  final List<String> hashcatOutput = [];
  bool running = false;

  hashcatCallback(text) {
    setState(() {
      hashcatOutput.last += '\n$text';
    });
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
        // duration: const Duration(milliseconds: 200),
        // curve: Curves.linear,
    ));
  }

  submit(String text) {
    if (text.isEmpty) return;

    setState(() => running = true);
    _textEditingController.clear();
    hashcatCommands.add(text);
    hashcatCommandPosition = hashcatCommands.length;
    hashcatOutput.add('');
    Provider.of<HashcatProvider>(context, listen: false).hashcat.instance.execute(
      text,
      callback: hashcatCallback,
    ).then((value) => setState(() => running = false));
  }

  moveCourseRelative(int amount) {
    final currentPosition = _textEditingController.selection.baseOffset;
    _textEditingController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: min(currentPosition + amount, _textEditingController.text.length),
      ),
    );
    _cliInputNode.requestFocus();
  }

  moveCommandHistory(int amount) {
    if (hashcatCommands.isEmpty) return;

    hashcatCommandPosition = max(min(hashcatCommandPosition + amount, hashcatCommands.length), 0);
    if (hashcatCommandPosition >= hashcatCommands.length) {
      _textEditingController.text = '';
      return;
    }

    _textEditingController.text = hashcatCommands[hashcatCommandPosition];
    _textEditingController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _textEditingController.text.length,
      ),
    );
  }

  showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  void dispose() {
    _cliInputNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args ??= ModalRoute.of(context)!.settings.arguments as CliArgs?;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _cliInputNode.requestFocus(),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: hashcatOutput.length + 1,
                  itemBuilder: (context, index) {
                    if (index == hashcatOutput.length) {
                      if (running) return const SizedBox.shrink();

                      return Row(
                        children: [
                          Text('Hashcat\$ ', style: GoogleFonts.sourceCodePro(),),
                          Expanded(
                            child: TextField(
                              controller: _textEditingController,
                              textInputAction: TextInputAction.send,
                              cursorColor: Colors.white,
                              focusNode: _cliInputNode,
                              style: Theme.of(context).textTheme.bodyText2,
                              // style: GoogleFonts.sourceCodePro(),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusColor: Colors.white,
                                fillColor: Colors.white,
                              ),
                              onSubmitted: submit,
                            ),
                          ),
                        ],
                      );
                    }

                    return SizedBox(
                      width: double.infinity,
                      child: SelectableText.rich(
                        textAlign: TextAlign.left,
                        TextSpan(
                          text: 'Hashcat\$ ',
                          style: GoogleFonts.sourceCodePro(),
                          children: [
                            TextSpan(text: hashcatCommands[index], style: Theme.of(context).textTheme.bodyText2,),
                            TextSpan(text: hashcatOutput[index], style: GoogleFonts.sourceCodePro(),),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => moveCourseRelative(-1),
                    child: const Text('←', style: TextStyle(color: Colors.white),),
                  ),
                  TextButton(
                    onPressed: () => moveCommandHistory(-1),
                    child: const Text('↑', style: TextStyle(color: Colors.white),),
                  ),
                  TextButton(
                    onPressed: () => moveCommandHistory(1),
                    child: const Text('↓', style: TextStyle(color: Colors.white),),
                  ),
                  TextButton(
                    onPressed: () => moveCourseRelative(1),
                    child: const Text('→', style: TextStyle(color: Colors.white),),
                  ),
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: const Text('Copy file path'),
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles();

                          if (result != null) {
                            ClipboardData data = ClipboardData(text: result.files.single.path);
                            await Clipboard.setData(data);
                            showSnackBar('Copied file path to your clipboard: ${result.files.single.path}');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hashcat_flutter/providers/hashcat.dart';
import 'package:provider/provider.dart';
import 'package:hashcat_flutter/providers/crack_options.dart';

class ProgressStepperStep {
  const ProgressStepperStep({required this.icon, required this.label});

  final Widget icon;
  final String label;
}

class ProgressStepper extends StatefulWidget {
  const ProgressStepper({
    Key? key,
    required this.steps,
    required this.pages,
  }) : assert(steps.length == pages.length),
    super(key: key);

  final List<ProgressStepperStep> steps;
  final List<Widget> pages;

  @override
  State<ProgressStepper> createState() => _ProgressStepperState();
}

class _ProgressStepperState extends State<ProgressStepper> {
  final PageController _pageController = PageController();
  int _page = 0;

  // TODO the hashcat execution and callback should definitely not live here.
  // Instead, the execute button could just push over to the CLI page and paste our command into the window.

  hashcatCallback(text) {
    print(text);
  }

  crack() {
    CrackOptionsProvider config = Provider.of<CrackOptionsProvider>(context, listen: false);

    String hashcatCmd = 'hashcat -m ${config.hashType} -a ${config.attackMode} --outfile-format ${config.outfileFormat.join(",")} ${config.target} ${config.dictionary} ${config.extraArgs}';
    print(hashcatCmd);

    Provider.of<HashcatProvider>(context, listen: false).hashcat.instance.execute(
      hashcatCmd,
      callback: hashcatCallback,
    );
  }

  next() {
    final index = min(_page + 1, widget.pages.length - 1);
    animateToPage(index);
  }

  previous() {
    final index = max(_page - 1, 0);
    animateToPage(index);
  }

  animateToPage(index) {
    _page = index;
    setState(() {

    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              LayoutBuilder(builder: (context, constraints) => Container(
                height: 3,
                width: constraints.maxWidth,
                color: Colors.grey,
              ),),
              LayoutBuilder(builder: (context, constraints) => AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.ease,
                height: 3,
                width: (constraints.maxWidth / (widget.steps.length + 1)) * (_page + 1),
                color: Theme.of(context).primaryColor,
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.steps.mapIndexed((index, step) => Container(
                  color: Theme.of(context).backgroundColor,
                  child: InkWell(
                    onTap: () => animateToPage(index),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          index <=_page ? Theme(
                            data: ThemeData(
                              iconTheme: IconThemeData(
                                color: Theme.of(context).primaryColor
                              ),
                            ),
                            child: step.icon,
                          ) : step.icon,
                          const SizedBox(height: 4,),
                          index ==_page ? Text(step.label) : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _page == 0 ? const SizedBox.shrink() : ElevatedButton(onPressed: previous, child: const Text('Previous')),
            _page == 2 ? ElevatedButton(onPressed: crack, child: const Text('Crack')) : ElevatedButton(onPressed: next, child: const Text('Next')),
          ],
        ),
      ),
    );
  }
}

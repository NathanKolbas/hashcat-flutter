import 'package:flutter/material.dart';
import 'package:hashcat_flutter/components/progress_stepper.dart';
import 'package:hashcat_flutter/pages/cracking/attack.dart';
import 'package:hashcat_flutter/pages/cracking/output.dart';
import 'package:hashcat_flutter/pages/cracking/target.dart';

class Cracking extends StatelessWidget {
  const Cracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProgressStepper(
      steps: const [
        ProgressStepperStep(
          icon: Icon(Icons.adjust),
          label: 'Target',
        ),
        ProgressStepperStep(
          icon: Icon(Icons.construction),
          label: 'Attack',
        ),
        ProgressStepperStep(
          icon: Icon(Icons.assignment_turned_in),
          label: 'Finalize',
        ),
      ],
      pages: const [
        Target(),
        Attack(),
        Output(),
      ],
    );
  }
}

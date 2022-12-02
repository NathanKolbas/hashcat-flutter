import 'package:flutter/material.dart';
import 'package:hashcat_flutter/constants.dart';

class Toolbox extends StatelessWidget {
  const Toolbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 50),
        const Text("Toolbox",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        const SizedBox(height: 50),
        ToolboxRow(
            onTap: () {
              print("CLI click");
            },
            iconData: Icons.terminal,
            label: "Run Hashcat on CLI"
        ),
        const SizedBox(height: 15),
        ToolboxRow(
            onTap: () {
              print("Benchmark click");
            },
            iconData: Icons.timer,
            label: "Run Benchmark"
        ),
        const SizedBox(height: 15),
        ToolboxRow(
            onTap: () {
              print("Hashcat Files click");
            },
            iconData: Icons.folder,
            label: "Hashcat Files"
        ),
      ],
    );
  }
}

class ToolboxRow extends StatelessWidget {
  final Function()? onTap;
  final IconData iconData;
  final String label;

  const ToolboxRow({
    this.onTap,
    required this.iconData,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: themeDark.dividerColor),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(iconData),
                  SizedBox(width: 25),
                  Text(label,
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ]
            )
            ,
          )
          ,
        ));
  }
}

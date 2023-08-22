import 'package:flutter/material.dart';

class ExpandableFabButton extends StatefulWidget {
  final List<String> options;

  const ExpandableFabButton({required this.options, Key? key})
      : super(key: key);

  @override
  State<ExpandableFabButton> createState() => _ExpandableFabButtonState();
}

class _ExpandableFabButtonState extends State<ExpandableFabButton> {
  bool isExpanded = false;
  String selectedOption = '';

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void selectOption(String option) {
    setState(() {
      selectedOption = option;
      isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: toggleExpanded,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Icon(Icons.list),
            !isExpanded
                ? Text(selectedOption)
                : Column(
                    children: widget.options.map((option) {
                      return ListTile(
                        title: Text(option),
                        onTap: () {
                          selectOption(option);
                        },
                      );
                    }).toList(),
                  )
          ],
        ),
      ),
    );
  }
}

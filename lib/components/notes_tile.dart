import 'package:flutter/material.dart';
import 'package:note_app/components/note_pop.dart';
import 'package:popover/popover.dart';
import 'dart:math';

class NotesTile extends StatelessWidget {
  final String text;
  final void Function()? onEdtPressed;
  final void Function()? onDelPreesed;

  NotesTile({
    super.key,
    required this.text,
    required this.onEdtPressed,
    required this.onDelPreesed,
  });

final List<Color> colors = [
  Colors.red.shade100,
  Colors.red.shade200,
  Colors.red.shade300,
  Colors.green.shade100,
  Colors.green.shade200,
  Colors.green.shade300,
  Colors.blue.shade100,
  Colors.blue.shade200,
  Colors.blue.shade300,
  Colors.yellow.shade100,
  Colors.yellow.shade200,
  Colors.yellow.shade300,
  Colors.orange.shade100,
  Colors.orange.shade200,
  Colors.orange.shade300,
  Colors.purple.shade100,
  Colors.purple.shade200,
  Colors.purple.shade300,
  Colors.grey.shade100,
  Colors.grey.shade200,
  Colors.grey.shade300,
];

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = colors[hashCode % colors.length];

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: ListTile(
        title: Text(
          text,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
        trailing: Builder(
          builder: (context) => IconButton(
            onPressed: () => showPopover(
              context: context,
              bodyBuilder: (context) => NotePop(
                onEditTap: onEdtPressed,
                onDelTap: onDelPreesed,
              ),
              width: 100,
              height: 100,
            ),
            icon: const Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}

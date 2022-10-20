import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.title,
    this.text,
    required this.icon,
  });

  final String title;
  final String? text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return buildWithoutText();
    } else {
      return buildWithText();
    }
  }

  Widget buildWithoutText() {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blueGrey,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWithText() {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blueGrey,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  text!,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

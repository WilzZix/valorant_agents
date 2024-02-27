import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.title,
    required this.checked,
  });

  final String title;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              color: checked
                  ? const Color(
                      0xFFDD3B4F,
                    )
                  : Colors.grey,
              fontSize: 16,fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 3,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(9),
            color: checked
                ? const Color(
                    0xFFDD3B4F,
                  )
                : Colors.grey,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ProfileItemTile extends StatelessWidget {
  final String title;
  final String content;

  const ProfileItemTile({
    super.key,
    required this.content,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          height: 50,
          child: Row(
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const Spacer(),
              Text(
                content,
                style:
                    const TextStyle(fontWeight: FontWeight.w200, fontSize: 13),
              ),
              const SizedBox(
                width: 10,
              ),
              // const Icon(
              //   Icons.arrow_forward_ios,
              //   size: 14,
              // )
            ],
          ),
        ),
      ),
    );
  }
}

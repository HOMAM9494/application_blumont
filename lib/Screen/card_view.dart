import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final String image;
  final String? departmentName;
  final String? mangerName;
  final String? Function(String?)? onTap;

  const CardView({
    super.key,
    this.image = 'asset/images/albert.png',
    this.departmentName = "New Grope",
    this.mangerName = "",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal.shade800,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Image(
            image: AssetImage(
              "assets/images/depart.png",
            ),
            width: 150,
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            departmentName!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

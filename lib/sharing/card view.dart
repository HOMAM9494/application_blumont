import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final String image;
  final String? title;
  final String? Function(String?)? onTap;

  const CardView({
    super.key,
    this.image='asset/images/albert.png',
    this.title ="New Grope",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsetsDirectional.all(5),
        child: Column(
          children: [
             Container(
               decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(25),color: Colors.blueAccent),
               child: Image(
                image: AssetImage("assets/images/albert.png",),width: 150,height: 200,
                 fit: BoxFit.fill,
                           ),
             ),
            SizedBox(height: 10,),
            Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

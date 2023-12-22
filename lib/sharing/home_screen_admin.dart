import 'package:application_blumont/sharing/card%20view.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("welcame"),),
      body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
         mainAxisExtent: 275,),
      children: [
        CardView(
          image: "assets/images/albert.png",
          title: "homam",
        ),
        CardView(
          image: "assets/images/albert.png",
          title: "homam",
        ),
        CardView(
          image: "assets/images/albert.png",
          title: "homam",
        ),
        CardView(
          image: "assets/images/albert.png",
          title: "homam",
        ),
      ],),

    );
  }
}

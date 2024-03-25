import 'package:flutter/material.dart';

// ignore: must_be_immutable

class DropdownButtonWidget extends StatefulWidget {
  final List<String> list1;
   String dropdownValue ;
   DropdownButtonWidget({super.key, required this.list1, required this.dropdownValue});

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(25),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width / 2,
        alignment: AlignmentDirectional.center,
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          menuMaxHeight: 200,
          value: widget.dropdownValue,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: const SizedBox(
            height: 2,
            width: 25,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              widget.dropdownValue = value!;
              print( widget.dropdownValue);
            });
          },
          items:
              widget.list1.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

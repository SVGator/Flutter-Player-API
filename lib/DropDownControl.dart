import 'package:flutter/material.dart';

class DropDownControl extends StatefulWidget {
  String value;
  final Function? onValueChange;
  final String property;
  final String display;
  final dynamic items;

  DropDownControl({
    Key? key,
    this.value = '10',
    this.property = '',
    this.display = '',
    this.onValueChange,
    this.items,
  }) : super(key: key);

  @override
  State<DropDownControl> createState() => _DropDownControlState();
}

class _DropDownControlState extends State<DropDownControl> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('${widget.display}:'),
              DropdownButton<String>(
                value: widget.value,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String ? newValue) {
                  setState(() {
                    widget.value = newValue!;
                    if (widget.onValueChange != null) {
                      widget.onValueChange?.call(widget.property, widget.value);
                    }
                  });
                },
                items: widget.items
              ),

            ]
        )
    );
  }
}

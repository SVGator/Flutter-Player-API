import 'package:flutter/material.dart';

String _defaultFormatter(double value) {
  return value.round().toString();
}

class SliderControl extends StatefulWidget {
  double value;
  final double min;
  final double max;
  final double step;
  final Function formatter;
  final Function? onValueChange;

  final String property;
  final String display;

  SliderControl({
    Key? key,
    this.value = 1,
    this.min = 1,
    this.max = 120,
    this.step = 1,

    this.property = '',
    this.display = '',
    this.formatter = _defaultFormatter,
    this.onValueChange,
  }) : super(key: key);

  @override
  State<SliderControl> createState() => _SliderControlState();
}

class _SliderControlState extends State<SliderControl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Column(
        children: <Widget>[
        Slider(
          value: widget.value,
          divisions: ((widget.max - widget.min) / widget.step).round(),
          min: widget.min,
          max: widget.max,
          label: widget.formatter(widget.value),
          onChanged: (double value) {
            setState(() {
              widget.value = value;
              if (widget.onValueChange != null) {
                widget.onValueChange?.call(widget.property, widget.value);
              }
            });
          },
        ),
        Text('${widget.display}: ' + widget.formatter(widget.value)),
        ]
    )
    ,
    );


  }
}

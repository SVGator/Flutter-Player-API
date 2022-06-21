import 'dart:ui';
import 'package:flutter/material.dart';
import './SliderControl.dart';
import './DropDownControl.dart';

String _speedFormatter(double value) {
  return (value * 100).round().toString() + '%';
}

String _iterationsFormatter(double value) {
  return value == 0
      ? '∞'
      : value.round().toString();
}

class MediaButtons extends StatelessWidget {
  final parentAction;
  const MediaButtons({Key? key, this.parentAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _getMediaButton(parentAction, 'play'),
                _getMediaButton(parentAction, 'pause'),
                _getMediaButton(parentAction, 'stop'),
                _getMediaButton(parentAction, 'reverse'),
                _getMediaButton(parentAction, 'toggle'),
              ]
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _getMediaButton(parentAction, 'seekBy', 'Seek -0.5s', -500),
                _getMediaButton(parentAction, 'seek', 'Seek 50%', 50),
                _getMediaButton(parentAction, 'seekBy', 'Seek +0.5s', 500),
                _getMediaButton(parentAction, 'restart'),
                _getMediaButton(parentAction, 'destruct'),
              ]
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SliderControl(
                  value: 1,
                  min: 0.01,
                  max: 10,
                  step: 0.01,
                  property: 'speed',
                  display: 'Speed',
                  formatter: _speedFormatter,
                  onValueChange: (property, value) {
                    parentAction(
                        command: 'set', param: value, property: property);
                  },
                ),

                SliderControl(
                  value: 1,
                  min: 0,
                  max: 25,
                  step: 1,
                  property: 'iterations',
                  display: 'Iterations',
                  formatter: _iterationsFormatter,
                  onValueChange: (property, value) {
                    parentAction(command: 'set', param: value, property: property);
                  },
                ),
              ]
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropDownControl(
                  value: 10.toString(),
                  property: 'direction',
                  display: 'Direction',
                  onValueChange: (property, value) {
                    int direction = int.parse(value).sign;
                    int alternate = (int.parse(value) % 10).abs();
                    parentAction(command: 'set', param: direction, property: property);
                    parentAction(command: 'set', param: alternate, property: 'alternate');
                  },
                  items: [
                      DropdownMenuItem<String>(
                        value: (10).toString(),
                        child: const Text('Normal'),
                      ),
                      DropdownMenuItem<String>(
                        value: (-10).toString(),
                        child: const Text('Reverse'),
                      ),
                      DropdownMenuItem<String>(
                        value: (11).toString(),
                        child: const Text('Alternate'),
                      ),
                      DropdownMenuItem<String>(
                        value: (-11).toString(),
                        child: const Text('Alternate Reverse'),
                      ),
                    ].toList()
                ),

                DropDownControl(
                  value: 1.toString(),
                  property: 'fill',
                  display: 'Fill mode',
                  onValueChange: (property, value) {
                    parentAction(
                        command: 'set', param: value, property: property);
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: (1).toString(),
                      child: const Text('Forwards'),
                    ),
                    DropdownMenuItem<String>(
                      value: (-1).toString(),
                      child: const Text('Backwards'),
                    ),
                  ].toList()
                ),
              ]
          ),

          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SliderControl(
                  value: 100,
                  min: 1,
                  max: 120,
                  step: 1,
                  property: 'fps',
                  display: 'FPS',
                  onValueChange: (property, value) {
                    parentAction(
                        command: 'set', param: value, property: property);
                  },
                ),
              ]
          ),

        ]
    );
  }
}

const _icons = {
  'play': Icons.play_arrow_rounded,
  'pause': Icons.pause_rounded,
  'stop': Icons.stop_rounded,
  'reverse': Icons.swap_horiz_rounded, // arrow_left_rounded
  'toggle': Icons.toggle_on_rounded,
  'Seek -0.5s': Icons.arrow_back_rounded,
  'Seek 50%': Icons.star_half_rounded,
  'Seek +0.5s': Icons.arrow_forward_rounded,
  'restart': Icons.restart_alt_rounded,
  'destruct': Icons.eject_rounded,
};

Widget _getMediaButton(Function parentAction, String command, [String? display = null, int? param = null]) {
  return Container(
    margin: const EdgeInsets.all(3),
    padding: const EdgeInsets.all(3),
    child:
    Column(
        children: <Widget>[
          IconButton(
            icon: Icon(_icons[display ?? command]),
            tooltip: display ?? command,
            onPressed: () {
              parentAction(command: command, param: param);
            },
          ),
          Text('${display ?? command}'),
        ]
    ),
  );
}

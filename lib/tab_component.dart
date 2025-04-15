import 'package:flutter/material.dart';

import 'dart:convert';

import './parts.dart';
import './event_log.dart';
import './media_buttons.dart';

import './Embed_Demo.dart' as svgator show EmbedDemo, EmbedDemoState;
import './External_Demo.dart' as svgator show ExternalDemo, ExternalDemoState;

class TabComponent extends StatefulWidget {
  static const String embed = 'embed';
  static const String external = 'external';

  final String? tab;

  const TabComponent({super.key, this.tab});

  @override
  TabComponentState createState() => TabComponentState();
}

class TabComponentState extends State<TabComponent> {
  final GlobalKey<EventLogState> _eventLog = GlobalKey();

  final GlobalKey<svgator.EmbedDemoState> _svgatorPlayerEmbed =
      GlobalKey<svgator.EmbedDemoState>();
  final GlobalKey<svgator.ExternalDemoState> _svgatorPlayerExternal =
      GlobalKey<svgator.ExternalDemoState>();

  void _eventListener([String? message]) {
    final data = jsonDecode(message ?? '{}');
    _eventLog.currentState?.updateLog(data['event'] ?? '', data['offset']);
  }

  void _runCommand(String command, int? param, String? property) {
    switch (widget.tab) {
      case TabComponent.embed:
        _svgatorPlayerEmbed.currentState?.runCommand(command, param, property);
        break;
      case TabComponent.external:
        _svgatorPlayerExternal.currentState?.runCommand(
          command,
          param,
          property,
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              logTitle('SVGator Player API - Event Log:', context),
              EventLog(key: _eventLog),
              widget.tab == TabComponent.embed
                  ? svgator.EmbedDemo(
                    height: 310,
                    key: _svgatorPlayerEmbed,
                    onMessage: _eventListener,
                  )
                  : widget.tab == TabComponent.external
                  ? svgator.ExternalDemo(
                    height: 310,
                    key: _svgatorPlayerExternal,
                    onMessage: _eventListener,
                  )
                  : const SizedBox.shrink(),
              MediaButtons(parentAction: _runCommand),
            ],
          ),
        ),
      ),
    );
  }
}

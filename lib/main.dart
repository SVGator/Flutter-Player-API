import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './parts.dart';
import './tab_component.dart' as svgator show TabComponent, TabComponentState;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVGator - Mobile Player API',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(primary: Colors.blueGrey),
      ),
      home: const MyHomePage(title: 'SVGator - Mobile Player API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _launchSvgatorAboutURL() async {
    const url = 'https://www.svgator.com/about-us';
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void _launchDocumentationURL() async {
    const url =
        'https://www.svgator.com/help/getting-started/svgator-player-js-api';
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(svgatorBlue),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: TextStyle(color: Colors.white)),
            IconButton(
              icon: Icon(Icons.info, color: Colors.white),
              onPressed: _launchSvgatorAboutURL,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          logo(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(
                  child: svgator.TabComponent(tab: svgator.TabComponent.embed),
                ),
                Center(
                  child: svgator.TabComponent(
                    tab: svgator.TabComponent.external,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: _launchDocumentationURL,
            child: const Text(
              "Tap here to see SVGator's Full API documentation.",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'space-mono',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Color(svgatorBlue),
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.code), text: "Embed"),
            Tab(icon: Icon(Icons.open_in_new), text: "External"),
          ],
        ),
      ),
    );
  }
}

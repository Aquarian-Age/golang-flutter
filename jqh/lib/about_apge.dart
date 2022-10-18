import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() => _AboutPageStat();
}

class _AboutPageStat extends State<AboutPage> {
  ///Future<void>? _launched;
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  final Uri toLaunch = Uri(scheme: 'https', host: 'github.com', path: '/Aquarian-Age/ccal');
  ////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "About",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          centerTitle: true, //标题居中显示
          toolbarHeight: 40, //标题高度
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                text: "个人业余作品 仅供参考",
                style: TextStyle(fontSize: 14, color: Colors.lightBlue),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                //_launched =
                    _launchInBrowser(toLaunch);
              }),
              child: const Text('GitHub'),
            ),
          ],
        ));
  }
}

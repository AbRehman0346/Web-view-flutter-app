import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import './xutils/xtextfield.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WebViewController _controller = WebViewController();

  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.canGoBack();
    _controller.canGoForward();
    _controller.loadRequest(Uri.parse(
        _addressController.text == "" ? "https://" : _addressController.text));
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
        actions: [
          //Go Back Button
          IconButton(
              onPressed: () {
                _controller.goBack();
              },
              icon: Icon(Icons.arrow_back_sharp)),
          //Go Forward Button
          IconButton(
              onPressed: () {
                _controller.goForward();
              },
              icon: Icon(Icons.arrow_forward_sharp)),
          const SizedBox(width: 10),
          //Address Button
          ElevatedButton(
              onPressed: () {
                _addressController.text = "https://";
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Enter Address"),
                          content: SizedBox(
                            height: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 220,
                                  child: XTextField(
                                    controller: _addressController,
                                    fontSize: 14,
                                  ),
                                ),
                                //Youtube.com Text Button
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _addressController.text =
                                            "https://youtube.com";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("Youtube.com")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _addressController.text =
                                            "https://web.whatsapp.com";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("Whatsapp.com")),
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: const Text("GO")),
                          ],
                        ));
              },
              child: const Text("Address")),
          const SizedBox(width: 10)
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

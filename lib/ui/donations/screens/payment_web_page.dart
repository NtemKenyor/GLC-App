import 'package:GLC/ui/donations/data/payment_utils.dart';
import 'package:GLC/ui/donations/widgets/payment_success_bottomsheet.dart';
import "package:flutter/material.dart";
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class OnlinePaymentPage extends StatefulWidget {
  final String paymentLink;

  OnlinePaymentPage({@required this.paymentLink});

  @override
  _OnlinePaymentPageState createState() => _OnlinePaymentPageState();
}

class _OnlinePaymentPageState extends State<OnlinePaymentPage> {
  InAppWebViewController _webViewController;
  double progress = 0;
  String url = "";
  final String redirectCallback = "payments/success/";
  double opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    print(widget.paymentLink);
    final provider = Provider.of<PaymentProvider>(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Opacity(
            opacity: opacity,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: progress < 1.0
                        ? LinearProgressIndicator(value: progress)
                        : Container()),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: InAppWebView(
                        initialUrlRequest:
                            URLRequest(url: Uri.parse(widget.paymentLink)),
                        initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions()),
                        onWebViewCreated: (InAppWebViewController controller) {
                          _webViewController = controller;
                        },
                        onProgressChanged:
                            (InAppWebViewController controller, int progress) {
                          setState(() {
                            this.progress = progress / 100;
                          });
                        },
                        onLoadStart: (controller, url) {
                          print(url);
                        },

                        onLoadStop: (controller, uri) {

                          setState(() {
                            opacity=1.0;
                          });
                          if (uri.toString().contains(redirectCallback)) {
                            showModalBottomSheet(
                                enableDrag: true,
                                isDismissible: true,
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return SuccessBottomSheet();
                                });
                          }
                        }),
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}

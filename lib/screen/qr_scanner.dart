import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:check/screen/participant_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:intl/intl.dart';

class QRViewScreen extends StatefulWidget {
  const QRViewScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewScreenState();
  //result!.code
}

class _QRViewScreenState extends State<QRViewScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Map<String, dynamic>? _data;
  void _loadData() async {
    if (!mounted) return; // Check if the widget is still mounted

    final url =
        Uri.parse("https://devfestcheck.onrender.com/data/${result!.code}");
    final Response res = await get(url);

    if (!mounted) return; // Check again before updating the state

    final Map<String, dynamic> data = jsonDecode(res.body);
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (result != null) {
      controller!.pauseCamera();
      _loadData();
      log(DateTime.tryParse(_data!["data"]["dateOfBirth"]).toString());
      Timer(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => ParticipantDetails(
                name:
                    "${_data!["data"]["firstName"]} ${_data!["data"]["lastName"]}",
                phoneNumber: _data!["data"]["phoneNumber"].toString(),
                email: _data!["data"]["email"].toString(),
                team: _data!["data"]["team"].toString(),
                birthDate: _data!["data"]["dateOfBirth"],
                state: _data!["data"]["state"].toString(),
              ),
            ),
          );
        }
      });
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: _buildQrView(context),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Scan a code'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: FutureBuilder(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset("assets/button.svg"),
                                Text(
                                  'Flash: ${snapshot.data}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

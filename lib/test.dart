import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:uni_links/uni_links.dart';
// import 'package:uni_links3/uni_links.dart';
import 'package:app_links/app_links.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';

class BankIDAuthScreen extends StatefulWidget {
  @override
  BankIDAuthScreenState createState() => BankIDAuthScreenState();
}

class BankIDAuthScreenState extends State<BankIDAuthScreen> {
  StreamSubscription? _sub;
  String? _authOrderRef;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
  //  _listenForDeepLinks();
  }



  Future<http.Client> getHttpClient() async {
    SecurityContext context = SecurityContext();



    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }

  String generateNonce() => Uuid().v4();

  Future<void> startBankIDAuth() async {
    setState(() => _isAuthenticating = true);
    final client = await getHttpClient();
    final iPAddress = await getPublicIPAddress();
    //final iPAddress = await getIPAddress();
    print("object");
    print(iPAddress);
    final Uri bankIDApiUrl = Uri.parse("https://www.frenly.se:4000/auth/start");

    final requestBody = {
      "endUserIp": iPAddress,
    };

    try {
      final response = await client.post(
        bankIDApiUrl,
        //headers: {"Content-Type": "application/json"},
        body: requestBody,
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _authOrderRef = responseData["orderRef"];
        print("object");
        print(_authOrderRef);
        print(iPAddress);
        print(responseData["autoStartToken"]);
        String autoLaunchUrl =
            "bankid:///?autostarttoken=${responseData["autoStartToken"]}&redirect=bankidapp://auth";
        await launchUrl(Uri.parse(autoLaunchUrl),
            mode: LaunchMode.externalApplication);
      } else {
        print("BankID Authentication Error: ${response.body}");
      }
    } catch (e) {
      print("Exception during BankID authentication: $e");
    } finally {
      setState(() => _isAuthenticating = false);
    }
  }

  // void _listenForDeepLinks() {
  //   _sub = uriLinkStream.listen((Uri? uri) {
  //     if (uri != null) handleDeepLink(uri);
  //   });
  //   getInitialUri().then((Uri? uri) {
  //     if (uri != null) handleDeepLink(uri);
  //   });
  // }

  void handleDeepLink(Uri uri) {
    if (uri.scheme == "bankidapp" && uri.host == "auth") {
      verifyBankIDAuth();
    }
  }

  Future<void> verifyBankIDAuth() async {
    if (_authOrderRef == null) return;
    final Uri verifyUrl =
    Uri.parse("https://www.frenly.se:4000/auth/collect");
    try {
      final response = await http.post(
        verifyUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"orderRef": _authOrderRef}),
      );

      if (response.statusCode == 200) {

        final responseData = jsonDecode(response.body);
        print("Authentication Failed: ${responseData}");
        if (responseData["status"] == "complete") {
          print("Authentication Successful");
        } else {
          print("Authentication Failed: ${responseData["status"]}");
        }
      } else {
        print("Verification Error: ${response.body}");
      }
    } catch (e) {
      print("Error verifying authentication: $e");
    }
    setState(() => _isAuthenticating = false);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BankID Authentication")),
      body: Center(
        child: _isAuthenticating
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: startBankIDAuth,
          child: Text("Authenticate with BankID"),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BankID Authentication',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BankIDAuthScreen(),
    );
  }
}

Future<String?> getIPAddress() async {
  try {
    // Check if device has internet connectivity
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Try to find a valid IPv4 address from network interfaces
      var interfaces = await NetworkInterface.list();
      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            return addr.address; // Returns the first IPv4 address found
          }
        }
      }
    } else {
      return "No internet connection"; // Handle no internet connection
    }
  } catch (e) {
    print("Failed to get IP address: $e"); // Log the error
    return "Error fetching IP address"; // Return error message
  }
  return "No IP address found"; // Return this if no IP address was found
}

Future<String?> getPublicIPAddress() async {
  try {
    final response = await http.get(Uri.parse('https://api.ipify.org'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Failed to get public IP";
    }
  } catch (e) {
    return "Error: $e";
  }
}
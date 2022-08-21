import 'dart:convert';
import 'dart:io';

import 'package:network_tools/network_tools.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:udp/udp.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Respray with ChangeNotifier {
  Future<void> sendudp(String data) async {
   //var sender = await UDP.bind(Endpoint.any(port: Port(44092)));
  
    // send a simple string to a broadcast endpoint on port 65001.
  //   var dataLength = await sender.send(data.codeUnits,
  //   Endpoint.broadcast(port: Port(44092)));
  //  print('$dataLength');
  //   stdout.write("$dataLength bytes sent.");
  //   var multicastEndpoint =
  //       Endpoint.multicast(InternetAddress("192.186.1.23"), port: Port(44092));
  // var sender = await UDP.bind(Endpoint.any());
  
  //   await sender.send(data.codeUnits, multicastEndpoint);

  var DESTINATION_ADDRESS=InternetAddress("127.0.0.1");

  RawDatagramSocket.bind(InternetAddress.anyIPv4, 44092).then((RawDatagramSocket udpSocket) {
    udpSocket.broadcastEnabled = true;
    udpSocket.listen((e) {
      Datagram? dg = udpSocket.receive();
      if (dg != null) {
        print("received ${dg.data}");
      }
    });
    List<int> data1 =utf8.encode(data);
    udpSocket.send(data1, DESTINATION_ADDRESS, 44092);
  });
  }

  Future<void> getIprespery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// Initialize Ip Address
    final info = NetworkInfo();
    var hostAddress = await info.getWifiIP();
    print(hostAddress.toString());
    String ip = hostAddress!;

    // or You can also get address using network_info_plus package
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final stream = HostScanner.getAllPingableDevices(subnet,
        firstSubnet: 1, lastSubnet: 50, progressCallback: (progress) {
      print('Progress for host discovery : $progress');
    });

    stream.listen((host) async {
      //Same host can be emitted multiple times
      //Use Set<ActiveHost> instead of List<ActiveHost>
      print('Found device: ${await host.deviceName}');
    }, onDone: () {
      print('Scan completed');
    }); // Don't forget to cancel the stream when not in use.
    notifyListeners();
  }
}

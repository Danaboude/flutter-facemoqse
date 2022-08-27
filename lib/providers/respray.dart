import 'dart:convert';
import 'dart:io';

import 'package:network_tools/network_tools.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'package:flutter/material.dart';

class Respray with ChangeNotifier {
  List<String> Ips = [];
  bool isdoneserarching = false;
  String ipaddress = '';
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
    if (ipaddress != '') {
      var DESTINATION_ADDRESS = InternetAddress(ipaddress);

      RawDatagramSocket.bind(InternetAddress.anyIPv4, 44092)
          .then((RawDatagramSocket udpSocket) {
        udpSocket.broadcastEnabled = true;
        udpSocket.listen((e) {
          Datagram? dg = udpSocket.receive();
          if (dg != null) {
            ipaddress = dg.address.address;
            print("received ${dg.address}");
          }
        });
        List<int> data1 = utf8.encode(data);
        udpSocket.send(data1, DESTINATION_ADDRESS, 44092);
      });
    }
  }

  void setisdoneserarching(bool iss) {
    isdoneserarching = iss;
    notifyListeners();
  }

  void setipaddress(String ip) {
    ipaddress = ip;

    notifyListeners();
  }

  Future<void> getIprespery() async {
    List<String> Ip = [];
     
    /// Initialize Ip Address
    final info = NetworkInfo();
    var hostAddress = await info.getWifiIP();
    print(hostAddress.toString());
    if (hostAddress != null) {
      String ip = hostAddress;

      // or You can also get address using network_info_plus package
      final String subnet = ip.substring(0, ip.lastIndexOf('.'));
      final stream = HostScanner.getAllPingableDevices(subnet,
          firstSubnet: 1, lastSubnet: 100, progressCallback: (progress) {
        print('Progress for host discovery : $progress');
      });

      stream.listen((host) async {
        //Same host can be emitted multiple times
        //Use Set<ActiveHost> instead of List<ActiveHost>
        print('Found device: ${await host.address}');
        sendudp(await host.address);
        Ip.add(await host.address);
      }, onDone: () {
        print('Scan completed');
      }); // Don't forget to cancel the stream when not in use.
      isdoneserarching = false;
      Ips = Ip;
    }
    notifyListeners();
  }
}

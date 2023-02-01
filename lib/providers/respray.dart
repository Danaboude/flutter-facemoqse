import 'dart:convert';
import 'dart:io';

import 'package:network_tools/network_tools.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_socket_plugin/flutter_socket_plugin.dart';
import 'package:udp/udp.dart';

class Respray with ChangeNotifier {
  List<String> Ips = [];
  bool isdoneserarching = false;
  List<String> ipaddress = [];

  Future<void> sendudp(String data) async {
    //send a simple string to a broadcast endpoint on port 65001.
    /*var sender = await UDP.bind(InternetAddress.anyIPv4,(port: Port(44092)));
    printIps();
    // send a simple string to a broadcast endpoint on port 65001.
    var dataLength = await sender.send(
        data.codeUnits, Endpoint.broadcast(port: Port(44092)));

    stdout.write("$dataLength bytes sent.");

    // creates a new UDP instance and binds it to the local address and the port
    // 65002.
    var receiver = await UDP.bind(Endpoint.loopback(port: Port(44092)));

    // receiving\listenin
    // close the UDP instances and their sockets.
    sender.close();
    receiver.close();*/
    printIps();

    for (var i = 0; i < ipaddress.length; i++) {
      var DESTINATION_ADDRESS = InternetAddress(ipaddress[i]);

      RawDatagramSocket.bind(InternetAddress.anyIPv4, 44092)
          .then((RawDatagramSocket udpSocket) {
        udpSocket.broadcastEnabled = true;
        udpSocket.listen((e) {
          Datagram? dg = udpSocket.receive();
          if (dg != null) {
            // ipaddress = dg.address.address;
            print("received ${dg.address}");
          }
        });
        List<int> data1 = utf8.encode(data);
        udpSocket.send(data1, DESTINATION_ADDRESS, 44092);
        udpSocket.close();
      });
    }
  }

  Future<void> setisdoneserarching(bool iss) async {
    isdoneserarching = iss;
    notifyListeners();
  }

  void setipaddress(String ip) {
    //ipaddress = ip;

    notifyListeners();
  }

  Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      print('== Interface: ${interface.name} ==');

      for (var addr in interface.addresses) {
        print(
            '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
        if (addr.address.isNotEmpty) {
          List<String> IpArray = addr.address.split(".");
          // print(addr.rawAddress[0].toString() +
          //     "." +
          //     addr.rawAddress[1].toString() +
          //     "." +
          //     addr.rawAddress[2].toString() +
          //     "." +
          //     "255");

          ipaddress.add(addr.rawAddress[0].toString() +
              "." +
              addr.rawAddress[1].toString() +
              "." +
              addr.rawAddress[2].toString() +
              "." +
              "255");
        }
      }
    }
  }

  Future<void> getIprespery() async {
    List<String> Ip = [];

    /// Initialize Ip Address
    final info = NetworkInfo();
    var hostAddress = await info.getWifiIP();
  
    if (hostAddress != null) {
      String ip = hostAddress;

      // or You can also get address using network_info_plus package
      final String subnet = ip.substring(0, ip.lastIndexOf('.'));
      final stream = HostScanner.getAllPingableDevices(subnet, progressCallback: (progress) {
      });

      stream.listen((host) async {
        //Same host can be emitted multiple times
        //Use Set<ActiveHost> instead of List<ActiveHost>
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

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
  String ipaddress = '192.168.0.104';

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
      udpSocket.close();
    });
  }

  Future<void> setisdoneserarching(bool iss) async {
    isdoneserarching = iss;
    notifyListeners();
  }

  void setipaddress(String ip) {
    ipaddress = ip;

    notifyListeners();
  }

  Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      print('== Interface: ${interface.name} ==');
      for (var addr in interface.addresses) {
        print(
            '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
        var IpArray = addr.address.split('.');
        ipaddress =
            IpArray[0] + "." + IpArray[1] + "." + IpArray[2] + "." + "255";
        print("BroadCasting" + ipaddress);
      }
    }
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
          firstSubnet: 1, lastSubnet: 255, progressCallback: (progress) {
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

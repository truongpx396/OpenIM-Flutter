import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openim_common/openim_common.dart';
import 'package:path_provider/path_provider.dart';

class Config {
  static Future init(Function() runApp) async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      cachePath = (await getApplicationDocumentsDirectory()).path;
      await DataSp.init();
      await Hive.initFlutter(cachePath);

      HttpUtil.init();
    } catch (_) {}

    runApp();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    var brightness = Platform.isAndroid ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));
  }

  static late String cachePath;
  static const uiW = 375.0;
  static const uiH = 812.0;

  static const String deptName = "OpenIM";
  static const String deptID = '0';

  static const double textScaleFactor = 1.0;

  static const secret = 'tuoyun';

  static const mapKey = '';

  static OfflinePushInfo offlinePushInfo = OfflinePushInfo(
    title: StrRes.offlineMessage,
    desc: "",
    iOSBadgeCount: true,
    iOSPushSound: '+1',
  );

  static const friendScheme = "io.openim.app/addFriend/";
  static const groupScheme = "io.openim.app/joinGroup/";

  // static const _host = "14.29.213.197";

  // static const _host = "127.0.0.1";

  // static const _host = "172.16.3.19";

  // static const _host = "172.16.3.20";

  // static const _host = "192.168.136.215";

  // static const _host = "192.168.1.181";

  // static const _host = "192.168.11.215";

  // static const _host = "192.168.136.215";

  // static const _host = "192.168.50.215";

  // static const _host = "192.168.3.50";

  // static const _host = "192.168.3.45";

  // static const _host = "192.168.3.47";

  static const _host = "openim.k8s.magiclab396.com";

  static const _ipRegex =
      '((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)';

  static bool get _isIP => RegExp(_ipRegex).hasMatch(_host);

  static String get serverIp {
    String? ip;
    var server = DataSp.getServerConfig();
    if (null != server) {
      ip = server['serverIP'];
      Logger.print('缓存serverIP: $ip');
    }
    return ip ?? _host;
  }

  static String get appAuthUrl {
    return "https://chat-openim.k8s.magiclab396.com";
    // String? url;
    // var server = DataSp.getServerConfig();
    // if (null != server) {
    //   url = server['authUrl'];
    //   Logger.print('Cache Auth url: $url');
    // }
    // return url ?? (_isIP ? "http://$_host:10008" : "https://$_host/chat");
  }

  static String get imApiUrl {
    String? url;
    var server = DataSp.getServerConfig();
    if (null != server) {
      url = server['apiUrl'];
      Logger.print('缓存apiUrl: $url');
    }
    // return url ?? (_isIP ? 'http://$_host:10002' : "https://$_host/api");
    return url ?? (_isIP ? 'http://$_host:10002' : "https://$_host");
  }

  static String get imWsUrl {
    return "wss://openim-gateway.k8s.magiclab396.com";
    // String? url;
    // var server = DataSp.getServerConfig();
    // if (null != server) {
    //   url = server['wsUrl'];
    //   Logger.print('缓存wsUrl: $url');
    // }
    // return url ?? (_isIP ? "ws://$_host:10001" : "wss://$_host/msg_gateway");
  }

  static String get objectStorage {
    String? storage;
    var server = DataSp.getServerConfig();
    if (null != server) {
      storage = server['objectStorage'];
      Logger.print('缓存objectStorage: $storage');
    }
    return storage ?? 'minio';
  }
}

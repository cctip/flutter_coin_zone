import 'package:get/get.dart';
import 'package:flutter_coin_zone/common/share_pref.dart';

class PredictionController extends GetxController {
  static final btcOptions = RxMap({ 'price': 0.00, 'rate': 0.00, 'risePrice': 0.00 });
  static final ethOptions = RxMap({ 'price': 0.00, 'rate': 0.00, 'risePrice': 0.00 });
  static final solOptions = RxMap({ 'price': 0.00, 'rate': 0.00, 'risePrice': 0.00 });

  // 初始化BTC数据
  static initBtc(info) {
    Map<String, double> map = {};
    map['price'] = info['quote']['USD']['price'];
    map['rate'] = info['quote']['USD']['percent_change_24h'];
    map['risePrice'] = info['quote']['USD']['volume_change_24h'];
    btcOptions.value = map;
  }
  // 初始化ETH数据
  static initEth(info) {
    Map<String, double> map = {};
    map['price'] = info['quote']['USD']['price'];
    map['rate'] = info['quote']['USD']['percent_change_24h'];
    map['risePrice'] = info['quote']['USD']['volume_change_24h'];
    ethOptions.value = map;
  }
  // 初始化SOL数据
  static initSol(info) {
    Map<String, double> map = {};
    map['price'] = info['quote']['USD']['price'];
    map['rate'] = info['quote']['USD']['percent_change_24h'];
    map['risePrice'] = info['quote']['USD']['volume_change_24h'];
    solOptions.value = map;
  }

  
}
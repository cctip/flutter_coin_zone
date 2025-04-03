import 'package:get/get.dart';
import 'package:flutter_coin_zone/common/share_pref.dart';

class PredictionController extends GetxController {
  static final btcOptions = RxMap({ 'price': 0.00, 'rate': 0.00, 'risePrice': 0.00, 'predict': '' });
  static final ethOptions = RxMap({ 'price': 0.00, 'rate': 0.00, 'risePrice': 0.00, 'predict': '' });
  static final solOptions = RxMap({ 'price': 0.00, 'rate': 0.00, 'risePrice': 0.00, 'predict': '' });

  // 初始化
  static init() {
    SharePref.setString('btcPredict', '');
    btcOptions['predict'] = SharePref.getString('btcPredict') ?? '';
    ethOptions['predict'] = SharePref.getString('ethPredict') ?? '';
    solOptions['predict'] = SharePref.getString('solPredict') ?? '';
  }

  // 初始化BTC数据
  static initBtc(info) {
    btcOptions['price'] = info['quote']['USD']['price'];
    btcOptions['rate'] = info['quote']['USD']['percent_change_24h'];
    btcOptions['risePrice'] = info['quote']['USD']['volume_change_24h'];
  }
  // 初始化ETH数据
  static initEth(info) {
    ethOptions['price'] = info['quote']['USD']['price'];
    ethOptions['rate'] = info['quote']['USD']['percent_change_24h'];
    ethOptions['risePrice'] = info['quote']['USD']['volume_change_24h'];
  }
  // 初始化SOL数据
  static initSol(info) {
    solOptions['price'] = info['quote']['USD']['price'];
    solOptions['rate'] = info['quote']['USD']['percent_change_24h'];
    solOptions['risePrice'] = info['quote']['USD']['volume_change_24h'];
  }

  // 预测BTC
  static onPredictBTC(val) {
    btcOptions['predict'] = val;
    SharePref.setString('btcPredict', val);
  }
  // 预测ETH
  static onPredictETH(val) {
    ethOptions['predict'] = val;
    SharePref.setString('ethPredict', val);
  }
  // 预测SOL
  static onPredictSOL(val) {
    solOptions['predict'] = val;
    SharePref.setString('solPredict', val);
  }
}
import 'dart:math';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/common/share_pref.dart';
import '/controller/user.dart';

var formater = DateFormat('yyyy-MM-dd');

class PredictionController extends GetxController {
  static final btcOptions = RxMap({ 'price': 0.00, 'rate': 0.00, 'risePrice': 0.00, 'predict': '' });
  static final ethOptions = RxMap({ 'price': 0.00, 'rate': 0.00, 'risePrice': 0.00, 'predict': '' });
  static final solOptions = RxMap({ 'price': 0.00, 'rate': 0.00, 'risePrice': 0.00, 'predict': '' });

  static final predictTimes = RxInt(0); // 预测次数
  static final predictSuccessTimes = RxInt(0); // 成功预测次数
  static final lastPredictTime = RxString(''); // 上次预测时间
  static final continuousPredict = RxInt(0); // 连续预测天数

  static final resultTime = RxString(''); // 上次公布结果时间
  static final resultBTC = RxBool(false); // BTC预测结果
  static final resultETH = RxBool(false); // ETH预测结果
  static final resultSOL = RxBool(false); // SOL预测结果
  static final resultRateBTC = RxDouble(0); // BTC预测结果值
  static final resultRateETH = RxDouble(0); // ETH预测结果值
  static final resultRateSOL = RxDouble(0); // SOL预测结果值
  static final claimedBTC = RxBool(false); // BTC领取结果
  static final claimedETH = RxBool(false); // ETH领取结果
  static final claimedSOL = RxBool(false); // SOL领取结果

  // 初始化
  static init() {
    btcOptions['predict'] = SharePref.getString('btcPredict') ?? '';
    ethOptions['predict'] = SharePref.getString('ethPredict') ?? '';
    solOptions['predict'] = SharePref.getString('solPredict') ?? '';
    predictTimes.value = SharePref.getInt('predictTimes') ?? 0;
    predictSuccessTimes.value = SharePref.getInt('predictSuccessTimes') ?? 0;
    lastPredictTime.value = SharePref.getString('lastPredictTime') ?? '';
    continuousPredict.value = SharePref.getInt('continuousPredict') ?? 0;
    claimedBTC.value = SharePref.getBool('claimedBTC') ?? false;
    claimedETH.value = SharePref.getBool('claimedETH') ?? false;
    claimedSOL.value = SharePref.getBool('claimedSOL') ?? false;
    initPrtResult();
  }

  // 初始化预测结果
  static initPrtResult() {
    DateTime now = DateTime.now();
    String today = formater.format(now);
    resultTime.value = SharePref.getString('resultTime') ?? '';
    if (resultTime.value == today) return;
    resultTime.value = today;
    SharePref.setString('resultTime', today);
    // 随机正负10内浮点数
    if (btcOptions['predict'] != '') {
      double randomData = Random().nextDouble() * 20 - 10;
      btcOptions['price'] = (btcOptions['price'] as double) + (btcOptions['price'] as double) * randomData;
      SharePref.setBool('resultBTC', btcOptions['predict'] == 'Up' && randomData > 0 || btcOptions['predict'] == 'Down' && randomData < 0);
      SharePref.setDouble('resultRateBTC', randomData);
    }
    if (ethOptions['predict'] != '') {
      double randomData = Random().nextDouble() * 20 - 10;
      ethOptions['price'] = (ethOptions['price'] as double) + (ethOptions['price'] as double) * randomData;
      SharePref.setBool('resultETH', ethOptions['predict'] == 'Up' && randomData > 0 || ethOptions['predict'] == 'Down' && randomData < 0);
      SharePref.setDouble('resultRateEth', randomData);
    }
    if (solOptions['predict'] != '') {
      double randomData = Random().nextDouble() * 20 - 10;
      solOptions['price'] = (solOptions['price'] as double) + (solOptions['price'] as double) * randomData;
      SharePref.setBool('resultSOL', solOptions['predict'] == 'Up' && randomData > 0 || solOptions['predict'] == 'Down' && randomData < 0);
      SharePref.setDouble('resultRateSol', randomData);
    }
    resultBTC.value = SharePref.getBool('resultBTC') ?? false;
    resultETH.value = SharePref.getBool('resultETH') ?? false;
    resultSOL.value = SharePref.getBool('resultSOL') ?? false;
    resultRateBTC.value = SharePref.getDouble('resultRateBTC') ?? 0;
    resultRateETH.value = SharePref.getDouble('resultRateETH') ?? 0;
    resultRateSOL.value = SharePref.getDouble('resultRateSOL') ?? 0;
  }

  // 重置预测结果
  static resetPrediction() {
    DateTime now = DateTime.now();
    String today = formater.format(now);
    if (lastPredictTime.value == today) return;
    SharePref.setString('btcPredict', '');
    SharePref.setString('ethPredict', '');
    SharePref.setString('solPredict', '');
    btcOptions['predict'] = '';
    ethOptions['predict'] = '';
    solOptions['predict'] = '';
  }

  // 初始化BTC数据
  static initBtc(info) {
    btcOptions['price'] = info['price'];
    btcOptions['rate'] = info['percent_change_24h'];
    btcOptions['risePrice'] = info['volume_change_24h'];
  }
  // 初始化ETH数据
  static initEth(info) {
    ethOptions['price'] = info['price'];
    ethOptions['rate'] = info['percent_change_24h'];
    ethOptions['risePrice'] = info['volume_change_24h'];
  }
  // 初始化SOL数据
  static initSol(info) {
    solOptions['price'] = info['price'];
    solOptions['rate'] = info['percent_change_24h'];
    solOptions['risePrice'] = info['volume_change_24h'];
  }

  // 预测BTC
  static onPredictBTC(val) {
    btcOptions['predict'] = val;
    SharePref.setString('btcPredict', val);
    increasePredictTimes();
  }
  // 预测ETH
  static onPredictETH(val) {
    ethOptions['predict'] = val;
    SharePref.setString('ethPredict', val);
    increasePredictTimes();
  }
  // 预测SOL
  static onPredictSOL(val) {
    solOptions['predict'] = val;
    SharePref.setString('solPredict', val);
    increasePredictTimes();
  }

  // 领取BTC预测奖励
  static onClaimBTC() {
    claimedBTC.value = true;
    SharePref.setBool('claimedBTC', true);
    UserController.increasePoint(50);
    UserController.increaseExp(20);
  }
  // 领取ETH预测奖励
  static onClaimETH() {
    claimedETH.value = true;
    SharePref.setBool('claimedETH', true);
    UserController.increasePoint(50);
    UserController.increaseExp(20);
  }
  // 领取SOL预测奖励
  static onClaimSOL() {
    claimedSOL.value = true;
    SharePref.setBool('claimedSOL', true);
    UserController.increasePoint(50);
    UserController.increaseExp(20);
  }

  // 新增预测次数
  static increasePredictTimes() {
    predictTimes.value++;
    SharePref.setInt('predictTimes', predictTimes.value);
    lastPredictTime.value = formater.format(DateTime.now());
    SharePref.setString('lastPredictTime', lastPredictTime.value);
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/controller/prediction.dart';
import '/common/utils.dart';

class ResultsBox extends StatefulWidget {
  final bool loading;
  const ResultsBox({super.key, required this.loading});

  @override
  State<ResultsBox> createState() => ResultsBoxState();
}

class ResultsBoxState extends State<ResultsBox> {
  bool get btcPrted => PredictionController.btcOptions['predict'] != '' || true;
  bool get ethPrted => PredictionController.ethOptions['predict'] != '';
  bool get solPrted => PredictionController.solOptions['predict'] != '';

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Results', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
        SizedBox(height: 12),
        Obx(() => Row(
          children: [
            btcPrted ? __resultItem('BTC') : Container(),
            SizedBox(width: btcPrted ? 10 : 0),
            ethPrted ? __resultItem('ETH') : Container(),
            SizedBox(width: ethPrted ? 10 : 0),
            solPrted ? __resultItem('SOL') : Container(),
          ],
        )),
        SizedBox(height: 20)
      ],
    );
  }

  Widget __resultItem(title) {
    var _icon, _resultData, _success, _resultRate, _claimed, _func;
    switch(title) {
      case 'BTC':
        _icon = 'BTC';
        _resultData = PredictionController.btcOptions['price'];
        _success = PredictionController.resultBTC.value;
        _resultRate = PredictionController.resultRateBTC.value;
        _claimed = PredictionController.claimedBTC.value;
        _func = () {
          Utils.showRewardDialog(context, points: 50, exp: 20);
          PredictionController.onClaimBTC();
        };
        break;
      case 'ETH':
        _icon = 'ETH';
        _resultData = PredictionController.ethOptions['price'];
        _success = PredictionController.resultETH.value;
        _resultRate = PredictionController.resultRateETH.value;
        _claimed = PredictionController.claimedETH.value;
        _func = () {
          Utils.showRewardDialog(context, points: 50, exp: 20);
          PredictionController.onClaimETH();
        };
        break;
      case 'SOL':
        _icon = 'SOL';
        _resultData = PredictionController.solOptions['price'];
        _success = PredictionController.resultSOL.value;
        _resultRate = PredictionController.resultRateSOL.value;
        _claimed = PredictionController.claimedSOL.value;
        _func = () {
          Utils.showRewardDialog(context, points: 50, exp: 20);
          PredictionController.onClaimSOL();
        };
        break;
    }
    return Stack(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 52) / 3,
          height: 134,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(119, 119, 119, 0.15),
                offset: Offset(4, 4),
                blurRadius: 8,
                spreadRadius: 0
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/home/$_icon.png', width: 32),
                  SizedBox(width: 8),
                  Text(title, style: TextStyle(color: Color(0xFF1B191C), fontWeight: FontWeight.w500))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${_resultData.toStringAsFixed(2)}', style: TextStyle(fontSize: 12)),
                  Text(
                    '${_resultRate >= 0 ? '+' : ''}${_resultRate.toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _resultRate >= 0 ? Color(0xFF3AD164) : Color(0xFFFF5151)
                    )
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8)
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF0C0C0D),
                    disabledForegroundColor: Color(0xFF2D2A2F),
                    disabledBackgroundColor: Color.fromRGBO(12, 12, 13, 0.15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _success ? (_claimed ? null : _func) : null,
                  child: Text(_success ? (_claimed ? 'Claimed' : 'Claim') : 'Failed', style: TextStyle(fontSize: 12))
                )
              )
            ],
          ),
        ),
        widget.loading ? Positioned(
          child: Container(
            width: (MediaQuery.of(context).size.width - 52) / 3,
            height: 134,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(24)),
            child: SizedBox(
              width: 30,
              height: 30,
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Color(0xFF5900CE),
                size: 30,
              ),
            ),
          )
        ) : Container(),
      ],
    );
  }
}
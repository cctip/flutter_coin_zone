import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/controller/prediction.dart';

class ResultsBox extends StatefulWidget {
  final bool loading;
  const ResultsBox({super.key, required this.loading});

  @override
  State<ResultsBox> createState() => ResultsBoxState();
}

class ResultsBoxState extends State<ResultsBox> {
  bool btcPrted = false;
  bool ethPrted = false;
  bool solPrted = false;

  @override
  initState() {
    super.initState();
    btcPrted = PredictionController.btcOptions['predict'] != '';
    ethPrted = PredictionController.ethOptions['predict'] != '';
    solPrted = PredictionController.solOptions['predict'] != '';
  }

  @override
  Widget build(BuildContext context) {
    return btcPrted || ethPrted || solPrted ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Results', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
        SizedBox(height: 12),
        Row(
          children: [
            btcPrted ? __resultItem('BTC', 'BTC', PredictionController.btcOptions, 'Claim', (){}) : Container(),
            SizedBox(width: btcPrted ? 10 : 0),
            ethPrted ? __resultItem('ETH', 'ETH', PredictionController.ethOptions, 'Faild', null) : Container(),
            SizedBox(width: ethPrted ? 10 : 0),
            solPrted ? __resultItem('SOL', 'SOL', PredictionController.solOptions, 'Claimed', null) : Container(),
          ],
        ),
        SizedBox(height: 32)
      ],
    ) : Container();
  }

  Widget __resultItem(icon, title, data, btn, func) {
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
                  Image.asset('assets/images/home/$icon.png', width: 32),
                  SizedBox(width: 8),
                  Text(title, style: TextStyle(color: Color(0xFF1B191C), fontWeight: FontWeight.w500))
                ],
              ),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${data['price'].toStringAsFixed(2)}', style: TextStyle(fontSize: 12)),
                  Text(
                    '${data['rate'] >= 0 ? '+' : ''}${data['rate'].toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: data['rate'] >= 0 ? Color(0xFF3AD164) : Color(0xFFFF5151)
                    )
                  )
                ],
              )),
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
                  onPressed: func,
                  child: Text(btn, style: TextStyle(fontSize: 12))
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
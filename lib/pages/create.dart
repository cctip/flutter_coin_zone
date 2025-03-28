import 'package:flutter/material.dart';

class CreateView extends StatefulWidget {
  const CreateView({super.key});

  @override
  State<CreateView> createState() => CreateViewState();
}

class CreateViewState extends State<CreateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F4),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top + 64,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 16,
                  child: InkWell(
                    child: Image.asset('assets/icons/close.png', width: 32),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ),
                Center(
                  child: Text('NFT Creation', style: TextStyle(color: Color(0xFF1B191C), fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Positioned(
                  right: 16,
                  child: Container(
                    width: 67,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Color(0xFFEDEFF1),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF0C0C0D),
                        disabledForegroundColor: Color.fromRGBO(27, 25, 28, 0.3),
                        disabledBackgroundColor: Color(0xFFEDEFF1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {},
                      child: Text('Save', style: TextStyle(fontSize: 16))
                    ),
                  )
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF5900CE),
                  borderRadius: BorderRadius.circular(40)
                ),
              ),
            )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(height: 64,color: Color(0xFFF2F3F4), width: MediaQuery.of(context).size.width - 32)
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  height: 80,
                  color: Color(0xFFF2F3F4),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
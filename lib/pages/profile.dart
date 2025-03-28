import 'package:flutter/material.dart';
import 'package:flutter_coin_zone/widget/information.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
        decoration: BoxDecoration(
          color: Color(0xff0F0F12),
          image: DecorationImage(image: AssetImage('assets/images/profile/profile_bg.png'), fit: BoxFit.fill)
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Infomation(context),
                  InkWell(
                    child: Image.asset('assets/icons/settings.png', width: 24),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                // clipBehavior: Clip.none,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 54,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color.fromRGBO(255, 255, 255, 0.3)
                                  )
                                )
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  height: 54,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color.fromRGBO(255, 255, 255, 0.3)
                                  )
                                )
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  height: 54,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color.fromRGBO(255, 255, 255, 0.3)
                                  )
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).padding.bottom + 80)
                        ],
                      )
                    )
                  ],
                ),
              )
            )
          ],
        )
      )
		);
	}
}
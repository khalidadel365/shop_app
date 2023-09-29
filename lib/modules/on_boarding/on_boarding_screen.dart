import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/login_screen.dart';

class BoardingModel{
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boarding =[
      BoardingModel(
          image: 'assets/images/on_board_1.json',
          title: 'Welcome',
          body: 'our app'),
      BoardingModel(
          image: 'assets/images/on_board_1.json',
          title: 'Shop Now',
          body: 'our app'),
      BoardingModel(
          image: 'assets/images/on_board_1.json',
          title: 'Our Products',
          body: 'our app')
    ];
    var pageController = PageController();
    bool isLast = false;
    void onSubmit (){
      CacheHelper.saveData(
          key: 'onBoarding',
          value: true)?.then((value) {
            if(value){
              navigateAndFinish(context, LoginScreen());
            }
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          defaultTextButton(
              function: onSubmit,
              text: 'SKIP')
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded  (
              child: PageView.builder(
                controller: pageController,
                physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                onPageChanged: (index){
                  if(index == boarding.length-1){
                    //List start from 1
                      isLast = true;
                      print(isLast);

                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 40 ,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  elevation: 0,
                    onPressed: (){
                    if(isLast==true){
                      onSubmit();
                    }
                    else{
                      print(isLast);
                      pageController.nextPage(
                          duration: const Duration(
                              milliseconds: 750
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                },
                  child: const Icon(
                      Icons.arrow_forward_ios,
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildBoardingItem(BoardingModel boarding) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Lottie.asset('${boarding.image}')),
      const SizedBox(
        height: 30,
      ),
      Text(
        '${boarding.title}',
        style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Text(
        '${boarding.body}',
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),
      ),
      const SizedBox(
        height: 20,
      ),

    ],
  );
}

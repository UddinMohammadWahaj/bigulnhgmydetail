import 'package:bigul_ekyc/screen/congratulations/CongratulationsController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CongratulationsScreen extends GetView<CongratulationsController> {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const Scaffold(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/bg_pattern.png",
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/mini_logo.png",
                ),
              ),
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Yay, you’ve completed all steps!',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Theme.of(context).hintColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),

                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Image.asset(
                      "assets/images/congratulations.png",
                      height: MediaQuery.of(context).size.height * 0.20,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Welcome to the Bigul Family!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                        "Congratulations, you are one of us now. Help us learn a little more about you by choosing your interests below.",textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Theme.of(context).hintColor)),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                        "I’m most excited about...",textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                           ),
                    Text(
                        "Select the cards below",textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall?.copyWith(color: Theme.of(context).hintColor,fontWeight: FontWeight.w400)
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    Obx(
                          ()=> MasonryGridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        itemCount: controller.interestList.length??0,
                        itemBuilder: (context, index) {
                          Interest item = controller.interestList[index];
                          return Card(

                            color: item.bgColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15) ,//<-- SEE HERE
                              side: item.isSelected!? BorderSide(
                                color: item.checkColor!,
                                width: 1
                              ): BorderSide.none,
                            ),

                           child: Stack(children: [



                             Center(
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Image.asset(
                                       item.imagepath!,
                                       height: 60,

                                       fit: BoxFit.cover,
                                     ),
                                     const SizedBox(
                                       height: 8,
                                     ),
                                   Text(
                                       item.name!,
                                       textAlign: TextAlign.center,

                                       style: Theme.of(context)
                                           .textTheme
                                           .displaySmall
                                   ),
                                 ],),
                               ),
                             ),
                             Checkbox(
                               checkColor: Colors.white,
                               activeColor: item.checkColor,
                               value: item.isSelected,
                               shape: const CircleBorder(),
                               onChanged: (bool? value) {
                                 item.isSelected = value;
                                 controller.interestList.refresh();
                               },
                             ),

                           ],),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed:
                             () {
                          controller.welcome(context);
                        },
                        // set the onPressed callback based on the isEnabled boolean value
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey;
                              } else {
                                return AppColors.primary;
                              }
                            },
                          ),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                              return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              );
                            },
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Let’s begin trading!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

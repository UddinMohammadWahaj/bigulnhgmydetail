import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetWidget extends GetView<BottomSheetWidgetController> {
  final String title;
  final String fill;
  final List<dynamic> list;
  final Function(dynamic) selectedValue;
 final  bool editable;
  const BottomSheetWidget(
      {Key? key,
      required this.title,
      required this.list,
      required this.selectedValue, required this.fill, required this.editable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomSheetWidgetController controller =
        Get.put(BottomSheetWidgetController(), tag: title);

    if(fill.isNotEmpty){
      controller.isValueSelected.value=true;
      controller.selectedValue.value=fill;
    }
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: editable
                ? () {
                    showList(context, title, list).then((value) {
                      if (value.isNotEmpty) {
                        controller.isValueSelected.value = true;
                        controller.selectedValue.value = value;
                        selectedValue(value);
                      } else {
                        controller.isValueSelected.value = false;
                        selectedValue("");
                      }
                    });
                  }
                : null,
            // set the onPressed callback based on the isEnabled boolean value
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: !controller.isValueSelected.value
                  ? MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return AppColors.lightGrey;
                        } else {
                          return AppColors.lightGrey;
                        }
                      },
                    )
                  : MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Theme.of(context).cardColor;
                        } else {
                          return Theme.of(context).cardColor;
                        }
                      },
                    ),
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                (Set<MaterialState> states) {
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: !controller.isValueSelected.value
                          ? BorderSide.none
                          : const BorderSide(
                              width: 1, color: AppColors.primary));
                },
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                      !controller.isValueSelected.value
                          ? title
                          : controller.selectedValue.value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              color: !controller.isValueSelected.value
                                  ? Colors.black
                                  : AppColors.primary)),
                ),
                Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetWidgetController extends GetxController {
  RxBool isValueSelected = false.obs;
  RxString selectedValue = "".obs;
}

Future<String> showList(
    BuildContext context, String title, List<dynamic> list) async {
  var result = await Get.bottomSheet(Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge),
        ),
        Flexible(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: list.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              var listItem = list[index];
              return ListTile(
                title: Text(listItem.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.w500)),
                onTap: () {
                  Get.back(result: listItem);
                },
              );
            },
          ),
        ),
      ],
    ),
  ));

  return result ?? "";
}

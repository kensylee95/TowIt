import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/config/colors.dart';
import 'package:logistics_app/controllers/core_controllers/choose_service_controller.dart';
import 'package:logistics_app/widgets/parent_widget.dart';
import 'package:logistics_app/widgets/positioned_bottom_container.dart';
import 'package:logistics_app/widgets/positioned_bottom_draggable_sheet.dart';
import 'package:logistics_app/widgets/positioned_search_bar.dart';

class ChooseService extends StatelessWidget {
  const ChooseService({super.key});

  @override
  Widget build(BuildContext context) {
    final ChooseServiceController controller = Get.put(ChooseServiceController());
    final Size size = MediaQuery.of(context).size;
    return ParentWidget(
      child: Stack(
        children: [
          Container(
            height: size.height * 0.6,
            width: size.width,
            color: Colors.green.withOpacity(0.5),
            child: const Center(
              child: Text("Map Data here"),
            ),
          ),
          PositionedSearchBar(
            size: size,
            onTap: (){},
            text: "Prefilled location",
          ),
          Obx(
            () => PositionedBottomDraggableSheet(
              minChildSize: 0.2,
              maxChildSize: controller.maxBottomSheetSize,
              initialChildSize: controller.dragDistance.value,
              onVerticalDragUpdate: (details) =>
                  controller.bottomSheetDragUpdate(details),
              onVerticalDragEnd: (details) =>
                  controller.bottomSheetDragEnd(details),
              child: ListView.builder(
                controller: controller.scrollController.value,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                itemCount: 2,
              ),
            ),
          ),
          PositionedBottomContainer(
            size: size,
            child: Obx(
              () => Container(
                width: size.width,
                height: controller.positionedBottomSheetHeight.value,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3)
                    )
                  ],
                  color: primary.withOpacity(0.5),
                  // borderRadius:
                  //BorderRadius.vertical(top: Radius.circular(30)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

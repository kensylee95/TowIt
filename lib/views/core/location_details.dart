import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logistics_app/config/colors.dart';
import 'package:logistics_app/controllers/core_controllers/location_details_controller.dart';
import 'package:logistics_app/widgets/icon_widget.dart';
import 'package:logistics_app/widgets/location_text_field.dart';
import 'package:logistics_app/widgets/map_box/map_box_display_widget.dart';
import 'package:logistics_app/widgets/parent_widget.dart';
import 'package:logistics_app/widgets/positioned_bottom_draggable_sheet.dart';
import 'package:logistics_app/widgets/toggler_widget.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationDetailsController controller =
        Get.put(LocationDetailsController());
    final Size size = MediaQuery.of(context).size;
    return ParentWidget(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: AppBar(
            elevation: 0,
            //iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          )),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (controller.dragDistance.value >= controller.maxBottomSheetSize) {
            controller.animateOnClose();
          }
        },
        child: Stack(
          children: [
            const Positioned.fill(
              child: MapBoxDisplayWidget(),
            ),
            Obx(
              () => PositionedBottomDraggableSheet(
                minChildSize: 0.1,
                maxChildSize: controller.maxBottomSheetSize,
                initialChildSize: controller.dragDistance.value,
                onVerticalDragUpdate: (details) =>
                    controller.bottomSheetDragUpdate(details),
                onVerticalDragEnd: (details) =>
                    controller.bottomSheetDragEnd(details),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TogglerWidget(onTap: controller.animateOnTap, size: size),
                    const SizedBox(height: 50,),
                    Obx(
                      () => controller.isLoadingLocations.value == true
                          ? SizedBox(
                              width: size.width,
                              height: size.height * 0.4,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Expanded(
                              child: controller.geoLocationModel.isEmpty?
                              SizedBox(
                                  width: size.width,
                                  height: size.height*0.4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.search_off_rounded, size: 80,),
                                      Text("Address not found", style: Theme.of(context).textTheme.labelSmall?.apply(color: Colors.grey.shade600),),
                                      Text("Choose on map", style: Theme.of(context).textTheme.labelMedium?.apply(color: Colors.green.shade600),)
                                    ],
                                  ),
                            )
                              : ListView.builder(
                                itemCount: controller.geoLocationModel.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      subtitle: Text(
                                    controller.geoLocationModel[index].address!,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ));
                                },
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Obx(
                () => Transform.translate(
                  offset:
                      Offset(0, controller.positionedBottomSheetHeight.value),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 35,
                    ),
                    width: size.width,
                    height: controller.smallerBottomsheetHeight * size.height,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0.5,
                            blurRadius: 0.5,
                            offset: const Offset(0, 3))
                      ],
                      color: surface,

                      // borderRadius:
                      //BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.destinationFieldfocusNode
                                          .unfocus();
                                      controller.pickUpFieldfocusNode.unfocus();
                                      controller.animateOnClose();
                                    },
                                    child: const IconWidget(
                                      height: 50,
                                      width: 50,
                                      icon: Icons.close,
                                      iconSize: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      border: null,
                                    ),
                                    child: Center(
                                      child: Text("Your route",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                  ),
                                ],
                              ),
                              const IconWidget(
                                height: 50,
                                width: 50,
                                icon: Icons.add,
                                iconSize: 25,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          height: size.height * 0.15,
                          width: size.width,
                          child: Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => LocationTextField(
                                      hasFocus:
                                          controller.pickUpFieldHasfocus.value,
                                      textEditingController:
                                          controller.pickUpLocation,
                                      hintText: "Search pick-up location",
                                      prefixIcon:
                                          Icons.location_searching_rounded,
                                      focusNode:
                                          controller.pickUpFieldfocusNode,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Obx(
                                    () => LocationTextField(
                                      hasFocus: controller
                                          .destinationFieldHasFocus.value,
                                      textEditingController:
                                          controller.destination,
                                      hintText: "Destination",
                                      prefixIcon: Icons.search_rounded,
                                      focusNode:
                                          controller.destinationFieldfocusNode,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

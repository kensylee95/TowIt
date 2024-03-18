import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/config/app_strings/assets.dart';
import 'package:logistics_app/config/colors.dart';
import 'package:logistics_app/config/sizes.dart';
import 'package:logistics_app/controllers/auth/phone_auth_controller.dart';
import 'package:logistics_app/views/components/forms/custom_elevated_button.dart';
import 'package:logistics_app/views/components/forms/custom_outlined_button.dart';
import 'package:logistics_app/views/components/forms/custom_text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final PhoneAuthController controller = Get.put(PhoneAuthController());
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(padding),
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your number",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              textController: controller.phoneNumber,
              prefixIcon: Text(
                " +234  ",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.apply(color: Colors.grey.shade800),
              ),
              hintText: "Enter Phone",
            ),
            const SizedBox(
              height: 15,
            ),
            CustomElevatedButton(
              size: size,
              text: "Sign in",
              color: primary,
              onPressed: () async => await controller
                  .verifyPhoneNumber(controller.phoneNumber.text.trim()),
            ),
            const SizedBox(
              height: spacing,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Divider(
                  color: surface,
                  endIndent: padding,
                )),
                Text(
                  "OR",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.apply(color: surface),
                ),
                Expanded(
                    child: Divider(
                  color: surface,
                  indent: padding,
                ))
              ],
            ),
            const SizedBox(
              height: spacing,
            ),
            CustomOutlinedButton(
                prefixWidget: const Image(
                  image: AssetImage(
                    googleImg,
                  ),
                  width: 30,
                  height: 30,
                ),
                textStyle: Theme.of(context).textTheme.labelSmall,
                size: size,
                text: "SignIn with Google"),
          ],
        ),
      ),
    );
  }
}

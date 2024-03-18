import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/config/colors.dart';
import 'package:logistics_app/config/sizes.dart';
import 'package:logistics_app/controllers/auth/phone_auth_controller.dart';
import 'package:pinput/pinput.dart';

class PhoneVerification extends StatelessWidget {
  const PhoneVerification({
    super.key,
    required this.verificationId,
    this.resendToken,
  });
  final String verificationId;
  final int? resendToken;
  @override
  Widget build(BuildContext context) {
    final PhoneAuthController controller = Get.put(PhoneAuthController());
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          size: 25,
          color: lightTextColor,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(padding),
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter the code",
                style: Theme.of(context).textTheme.displayMedium?.apply(
                      color: Colors.grey.shade700,
                    )),
            const SizedBox(
              height: spacing,
            ),
            Text(
              "An SMS code was sent to",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.apply(color: Colors.grey.shade600),
            ),
            Text(
              "+234 9061892107",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.apply(color: Colors.grey.shade800),
            ),
            const SizedBox(
              height: spacing,
            ),
            Obx(
              () => Pinput(
                androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                length: 6,
                keyboardType: TextInputType.number,
                controller: controller.verificationCode.value,
                closeKeyboardWhenCompleted: true,
                onCompleted: (otp) {
                  controller.verifyOtp(otp, verificationId);
                },
                defaultPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 4, color: surface))),
              ),
            ),
            SizedBox(
              width: size.width * 0.5,
              child: TextButton(
                onPressed: () {},
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Resend Code",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.apply(color: primary),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

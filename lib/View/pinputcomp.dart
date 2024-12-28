import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

import '../Model/CreateAccountFuncs.dart';
import '../main.dart';

class PinputComp extends StatefulWidget {
  const PinputComp({Key? key}) : super(key: key);

  @override
  State<PinputComp> createState() => _PinputCompState();
}

class _PinputCompState extends State<PinputComp> {
 // late final SmsRetriever smsRetriever;

 
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();

    /// In case you need an SMS autofill feature
    // smsRetriever = SmsRetrieverImpl(
    //   SmartAuth(),
    // );
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var focusedBorderColor = Color.fromRGBO(20, 20, 20,1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(20, 20, 20,1);

    final defaultPinTheme = PinTheme(
      width: 76,
      height: 76,
      textStyle: const TextStyle(
        fontSize: 42,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Material(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Directionality(
              // Specify direction if desired
              textDirection: TextDirection.ltr,
              child: Pinput(
                // You can pass your own SmsRetriever implementation based on any package
                // in this example we are using the SmartAuth
              //  smsRetriever: smsRetriever,

                controller: pinController,
                focusNode: focusNode,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                validator: (value) {
            
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                focusNode.unfocus();
                formKey.currentState!.validate();
              },
              child: MaterialButton(padding: const EdgeInsets.all(20),onPressed: () async{
              //  bool? code= await CreateAccountFuncs.verifyCode(pinController.text);
               //code!=null&& code==true
                if(true) {
                  Get.offAllNamed('/dataEntry');
                }
                else
                {
                  Get.snackbar('Error', 'incorrect pin code',backgroundGradient:LinearGradient(colors: [Colors.red,Colors.white]),snackPosition: SnackPosition.BOTTOM );
                  pinController.text="";
                 //make theme red
                }

                },child: const Text('Enter verification code',style: TextStyle(fontSize: 30,color: Color.fromRGBO(30, 60, 87, 1),),),),
            ),
            MaterialButton(padding: const EdgeInsets.all(10),onPressed: () async {

            await CreateAccountFuncs.sendVerificationCode();
            pinController.text="";
            },child:   const Text('send new code',style: TextStyle(fontSize: 20,color: Color.fromRGBO(30, 60, 87, 1),),),
            )

          ],
        ),
      ),
    );
  }
}

/// You, as a developer should implement this interface.
/// You can use any package to retrieve the SMS code. in this example we are using SmartAuth
// class SmsRetrieverImpl implements SmsRetriever {
//   const SmsRetrieverImpl(this.smartAuth);
//
//  // final SmartAuth smartAuth;
//
//   @override
//   Future<void> dispose() {
//   //  return smartAuth.removeSmsListener();
//   }
//
//   @override
//   Future<String?> getSmsCode() async {
//     final signature = await smartAuth.getAppSignature();
//     debugPrint('App Signature: $signature');
//     final res = await smartAuth.getSmsCode(
//       useUserConsentApi: true,
//     );
//     if (res.succeed && res.codeFound) {
//       return res.code!;
//     }
//     return null;
//   }
//
//   @override
//   bool get listenForMultipleSms => false;
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_delievery/Controller/UserDataController.dart';
import 'package:order_delievery/Model/CreateAccountFuncs.dart';


import '../main.dart';
import 'components/GradientText.dart';
UserDataController controller =Get.put(UserDataController(),permanent: true);
class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email=TextEditingController();
  GlobalKey<FormState> formState=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top: 100,left: 50,right: 50,bottom: 50),
        child: Form(
          key: formState,
          child: Column(
            children: [
              GradientText('Create Account',style: Theme.of(context).textTheme.headlineMedium, gradient: LinearGradient(colors: [
                Colors.yellow,
                Colors.black,



              ]),),
              const SizedBox(height: 40),
              TextFormField(
                cursorColor: Colors.black,
                controller:phoneNumber,
                validator: (value){
                  if(value!.isEmpty)
                    return 'required field';
                  if(!value.isPhoneNumber)
                    return 'phone number not valid';
                  return null;
                },
                keyboardType: TextInputType.phone,
                decoration:  InputDecoration(
                  labelText: "phone number",
                  labelStyle:Theme.of(context).textTheme.bodyLarge ,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),

              ), const SizedBox(height: 40)
              ,TextFormField(
                cursorColor: Colors.black,
                controller:email,
                validator: (value){
                  if(value!.isEmpty)
                    return 'required field';
                  if(!value.isEmail)
                    return 'email not valid';
                  return null;
                },
                keyboardType: TextInputType.phone,
                decoration:InputDecoration(
                  labelText: "email",
                  labelStyle:Theme.of(context).textTheme.bodyLarge  ,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                cursorColor: Colors.black,
                controller:password,
                validator: (value){

                    if (value != null) {
                      if (value.isEmpty) {
                        return "Required Field";
                      } else if (value.length < 8) {
                        return "Password Must be At Least 8 Characters";
                      } else if (RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                        return 'Password Should Contain Numbers & Characters';
                      } else if (RegExp(r'^[a-z]+$').hasMatch(value)) {
                        return 'Password Should Contain Numbers & Characters';
                      } else {
                        return null;
                      }
                    } else {
                      return null;
                    }



                },

                keyboardType: TextInputType.phone,
                decoration:  InputDecoration(
                  labelText: "password",
                  labelStyle:Theme.of(context).textTheme.bodyLarge  ,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                cursorColor: Colors.black,
                validator: (value){
                  if(value!.isEmpty)
                    return 'required field';
                  if(value!=password.text)
                    return "password not match";
                  return null;
                },

                keyboardType: TextInputType.phone,
                decoration:  InputDecoration(

                  labelText: "Confirm password",
                  labelStyle:Theme.of(context).textTheme.bodyLarge  ,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              MaterialButton(color: Colors.yellow[200],
                minWidth: MediaQuery.of(context).size.width-100,
                height: 55,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () async{

                    if(formState.currentState!.validate()) {

                      controller.password=password.text;
                      controller.number=phoneNumber.text;
                      controller.email=email.text;

                      userData?.setString('email',email.text);
                      userData?.setString('phone',phoneNumber.text);
                    //  await CreateAccountFuncs.sendVerificationCode();
                      Get.toNamed('/pinput_comp');

                    }
  }
                  ,child: Text('Register',style: Theme.of(context).textTheme.titleLarge,),
                  ),
              Container(

                  child: MaterialButton(onPressed: (){
                    Get.offNamed('/login');
                  },child: Text("Already have an account?",style: TextStyle(fontSize: 20,color: Colors.blue,
                  ),))
              )
            ],
          ),
        ),
      ),
    );
  }
}






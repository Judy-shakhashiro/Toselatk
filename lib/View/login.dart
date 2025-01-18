import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_delievery/Model/LoginFuncs.dart';
import '../main.dart';
import 'components/GradientText.dart';
import 'delivary_page.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

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
              GradientText('Login',style: Theme.of(context).textTheme.headlineMedium, gradient: LinearGradient(colors: [
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
                  else if(!value!.isPhoneNumber)
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
              ,
              TextFormField(
                cursorColor: Colors.black,
                controller:password,
                validator: (value){

                  if (value != null) {
                    if (value.isEmpty) {
                      return "required field";
                    } else if (value.length < 8) {
                      return "wrong password";
                    } else if (RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                      return 'wrong password';
                    } else if (RegExp(r'^[a-z]+$').hasMatch(value)) {
                      return 'wrong password';
                    } else {
                      return null;
                    }
                  } else {
                    return null;
                  }



                },

                keyboardType: TextInputType.text,
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
              MaterialButton(color: Colors.yellow[200],
                minWidth: MediaQuery.of(context).size.width-100,
                height: 55,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: () async{



                  if(formState.currentState!.validate()){

                   await LoginFuncs.login(phoneNumber.text, password.text);

                   if(userData?.getString('token')!=null)
                    Get.off(DelivaryPage());
                   else
                     Get.snackbar('Error', 'wrong number or password',backgroundGradient: LinearGradient(colors: [Colors.red,Colors.white]),snackPosition: SnackPosition.BOTTOM);

                  }
                }
                ,child:  Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text('login',style: TextStyle(fontSize: 20),), Icon(Icons.arrow_right_alt_sharp,size: 40,),]),
              ),
              Container(

                  child: MaterialButton(onPressed: (){
                    print(userData?.getString('email'));
                    Get.offNamed('/create_account');
                  },child: Text("Don't have an account ?",style: TextStyle(fontSize: 20,color: Colors.blue,
                  ),))
              )
            ],
          ),
        ),
      ),
    );
  }
}


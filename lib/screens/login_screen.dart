import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  bool _isLoading=false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  
  void loginUser() async{
    setState(() {
      _isLoading=true;
    });
    String res=await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text
    );
      if(res=='success'){

      }else{
        showSnackBar(res, context);
      }
      setState(() {
        _isLoading=false;
      });
  }
  void navigateToSignup(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=>const SignupScreen()
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 33),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Container(),flex: 2,),
            SvgPicture.asset('assets/ic_instagram.svg',color: primaryColor,height: 64,),
            const SizedBox(height: 64,),
            TextFieldInput(
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress,
              isPass: false,
              textEditingController: _emailController,
            ),
            const SizedBox(height: 24,),
            TextFieldInput(
              hintText: "Enter your password",
              textInputType: TextInputType.text,
              isPass: true,
              textEditingController: _passwordController,
            ),
            const SizedBox(height: 24,),
            InkWell(
              onTap: () {
                loginUser();
              },
              child: Container(
                child: _isLoading ? 
                const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                    ),) : 
                    Text('Login'),
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: blueColor,
                    ),
                ),
            ),
               const SizedBox(height: 12,),
               Flexible(child: Container(),flex: 2,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account? "),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap:(){navigateToSignup();},
                    child: Container(
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold),),
                      padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                  )
                ],
                )
          ],
        ),
      ))
    );
  }
}
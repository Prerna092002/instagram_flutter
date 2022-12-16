import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';

import '../widgets/text_field_input.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _bioController=TextEditingController();
  final TextEditingController _usernameController=TextEditingController();
  Uint8List? _image;
  bool _isLoading=false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }
  void selectImage() async{
    Uint8List im=await pickImage(ImageSource.gallery);
    setState(() {
      _image=im;
    });
  }

  void signUpUser() async{
    setState(() {
      _isLoading=true;
    });
      String res= await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file:_image!,
        );
        setState(() {
          _isLoading=false;
        });
       if(res!= 'success'){
      showSnackBar(res, context);
       }else{
        //
       }
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
            Stack(children: [
             _image!=null ?
             CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(_image!),
              )
             : const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
              ),
              Positioned(
                bottom: -10,
                left:80,
                child: IconButton(
                  onPressed: selectImage,
                   icon: const Icon(Icons.add_a_photo),
                   ))
            ],),
            const SizedBox(height: 24,),
             TextFieldInput(
              hintText: "Enter your name",
              textInputType: TextInputType.text,
              isPass: false,
              textEditingController: _usernameController,
            ),
            const SizedBox(height: 24,),
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
              TextFieldInput(
              hintText: "Enter your bio",
              textInputType: TextInputType.text,
              isPass: false,
              textEditingController: _bioController,
            ),
            const SizedBox(height: 24,),
            InkWell(
              onTap: () {
             signUpUser();
              },
              child: Container(
                child: _isLoading ? 
                const Center(child: CircularProgressIndicator(color: primaryColor,),)  
                : Text('Signup'),
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
                    child: const Text("Already have an account? "),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap:(){},
                    child: Container(
                      child: const Text(
                        "Login",
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
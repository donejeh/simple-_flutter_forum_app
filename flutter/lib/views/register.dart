import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/controllers/authController.dart';
import 'package:testing/views/login.dart';
import 'package:testing/views/widgets/input_widget.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register Page',
                style: GoogleFonts.poppins(fontSize: size * 0.040),
              ),
              SizedBox(height: 30,),

              InputWidget(
                hintText: 'Full Name',
                obscureText: false,
                controller: _nameController,
              ),
              SizedBox(height: 30,),

              InputWidget(
                hintText: 'Username',
                obscureText: false,
                controller: _usernameController,
              ),
              SizedBox(height: 30,),

              InputWidget(
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
              ),
              SizedBox(height: 30,),
              InputWidget(
                hintText: 'password',
                obscureText: true,
                controller: _passwordController,
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        )
                    ),
                    onPressed: () async {
                      await _authController.register(
                          name : _nameController.text.toString(),
                          username: _usernameController.text.toString(),
                          email : _emailController.text.toString(),
                          password : _passwordController.text.toString()
                      );

                    },
                    child:
                    Obx(() {
                      return _authController.isLoading.value
                          ? Center(child: CircularProgressIndicator(color: Colors.white,))
                          : Text('Register',style: GoogleFonts.poppins(fontSize: size * 0.040),);

                   }),

                  ),

              const SizedBox(height: 30,),

              TextButton(
                onPressed: (){
                  Get.to(() => LoginPage());
                },
                child: Text('Login',
                  style: GoogleFonts.poppins(
                      fontSize: size * 0.040,
                      color: Colors.black
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

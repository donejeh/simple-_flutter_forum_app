import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/controllers/authController.dart';
import 'package:testing/views/register.dart';
import 'package:testing/views/widgets/input_widget.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login Page',
                style: GoogleFonts.poppins(fontSize: size * 0.080),
              ),
              SizedBox(height: 30,),

             InputWidget(
              hintText: 'Email or username',
              obscureText: false,
              controller: _usernameController,
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

                  await _authController.login(username: _usernameController.text.trim(),
                      password: _passwordController.text.trim());

                  },
                  child: Obx((){

                      return _authController.isLoading.value ?
                      const CircularProgressIndicator(
                        color: Colors.white,
                      ) :
                      Text('Login',
                        style: GoogleFonts.poppins(fontSize: size * 0.040),
                      );
                    }
                  ),),

              const SizedBox(height: 30,),

              TextButton(
                  onPressed: (){
                   Get.to(() => RegisterPage());
                  },
                  child: Text('Register',
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

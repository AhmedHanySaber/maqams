import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/config/routes.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import '../../../../core/utils/colors.dart';
import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                    left: -130,
                    bottom: -150,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'assets/images/img1.png',
                        height: 500,
                        width: 500,
                        fit: BoxFit.cover,
                      ),
                    )),
                Positioned(
                  top: null,
                  right: null,
                  bottom: null,
                  left: null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Center(
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 300,
                                  width: 500,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: _userNameController,
                                    decoration: InputDecoration(
                                      hintText: 'Name'.tr,
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      hintText: 'Email'.tr,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: obscurePassword,
                                    decoration: InputDecoration(
                                      hintText: 'Password'.tr,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            obscurePassword = !obscurePassword;
                                          });
                                          print(obscurePassword);
                                        },
                                        child: Icon(
                                          obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.black,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: BlocConsumer<AuthCubit, AuthState>(
                                    listener: (context, state) {
                                      if (state is RegisterSuccess) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "welcome to our app${state.userCredential.user!.email ?? ""}"),
                                            duration:
                                                const Duration(seconds: 2),
                                            backgroundColor: AppColors.primaryColor,
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      }
                                      // TODO: implement listener
                                    },
                                    builder: (context, state) {
                                      AuthCubit cubit = AuthCubit.get(context);
                                      if (state is RegisterLoading) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }

                                      return ElevatedButton(
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            await cubit.register(
                                                fullName:
                                                    _userNameController.text,
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryColor,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Sign up'.tr,
                                          style: AppFontStyle.white_18,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.green,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 40,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.loginScreen);
                                      },
                                      child: Text(
                                        'already have an account?'.tr,
                                        style: AppFontStyle.black_18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

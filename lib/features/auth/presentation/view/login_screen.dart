import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/config/routes.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/colors.dart';
import 'package:maqam_v2/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:maqam_v2/features/auth/presentation/controllers/auth_state.dart';
import '../../../../core/utils/validation/validation.dart';
import '../../../drawer/presentation/screens/drawer_screen.dart';
import '../../../modules/presentation/view/modules_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                    top: 2,
                    left: 170,
                    child: Image.asset(
                      'assets/images/img3.png',
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    )),
                Positioned(
                    left: -150,
                    bottom: -140,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'assets/images/img2.png',
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
                        child: Container(
                          constraints: null,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: Colors.white),
                          child: Padding(
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
                                      height: 250,
                                      width: 300,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextFormField(
                                        validator: validateEmail,
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          hintText: 'Email'.tr,
                                          hintStyle: AppFontStyle.grey_14,
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
                                    const SizedBox(height: 30),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextFormField(
                                        validator: validatePassword,
                                        controller: _passwordController,
                                        obscureText: obscurePassword,
                                        decoration: InputDecoration(
                                          hintText: 'Password'.tr,
                                          hintStyle: AppFontStyle.grey_14,
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: Colors.black,
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                obscurePassword =
                                                    !obscurePassword;
                                              });
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
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: BlocConsumer<AuthCubit, AuthState>(
                                        listener: (context, state) {
                                          if (state is LoginSuccess) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "welcome to our app${state.userCredential!.displayName ?? ""}"),
                                                duration:
                                                    const Duration(seconds: 3),
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                            Get.offAll(
                                                () => const ModulesScreen());
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is LoginLoading) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }

                                          return ElevatedButton(
                                            onPressed: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                formKey.currentState!.save();
                                                await AuthCubit.get(context)
                                                    .login(
                                                  context,
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text,
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              'Sign in'.tr,
                                              style: AppFontStyle.white_22,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Don\'t have an account?'.tr,
                                          style: AppFontStyle.black_14,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.SignUpScreen);
                                          },
                                          child: Text('Sign up'.tr,
                                              style:
                                                  AppFontStyle.primary_12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        debugPrint("click");
                                        await AuthCubit.get(context)
                                            .authRepo
                                            .signInAsGuest();
                                        Get.to(() => const ModulesScreen());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('continue as a guest'.tr,
                                              style:
                                                  AppFontStyle.primaryBold_14),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            size: 18,
                                            color: AppColors.primaryColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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

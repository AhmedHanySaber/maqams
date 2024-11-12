import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:maqam_v2/features/auth/presentation/controllers/auth_state.dart';
import '../../../core/utils/colors.dart';
import '../../../core/widgets/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthCubit.get(context).getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile".tr,
        isRoot: false,
      ),
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is GetUserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetUserSuccess) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Text(
                        "Name".tr,
                        style: AppFontStyle.primary_16,
                      ),
                    ),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          enabled: false,
                          hintText: state.userModel.fullName,
                          hintStyle: AppFontStyle.black_16,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r))),
                    ),
                    Gap(20.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Text(
                        "Email".tr,
                        style: AppFontStyle.primary_16,
                      ),
                    ),
                    InkWell(
                      onLongPress: () {
                        Clipboard.setData(
                            ClipboardData(text: state.userModel.fullName));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Email copied to clipboard'.tr,
                            ),
                            backgroundColor: AppColors.primaryColor,
                          ),
                        );
                      },
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          enabled: false,
                          hintText: state.userModel.email,
                          hintStyle: AppFontStyle.black_16,
                          prefixIcon:
                              Icon(Icons.email, color: AppColors.primaryColor),
                          suffixIcon: Padding(
                            padding: EdgeInsetsDirectional.only(end: 8.w),
                            child: CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 12,
                                child: const Icon(Icons.copy, color: AppColors.white)),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is GetUserError) {
              return Center(
                child: Text(state.error, style: AppFontStyle.black_18),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: AppColors.primaryColor4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text("Ok".tr, style: AppFontStyle.white_18),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/widgets/custom_appbar.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_state.dart';
import 'package:maqam_v2/features/reservation/presentation/screens/ReservationScreen.dart';
import 'package:maqam_v2/features/cart/presentation/view/widgets/cart_item.dart';
import 'package:maqam_v2/features/reservation/presentation/screens/all_reservations_screen.dart';
import '../../../../core/utils/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final list = CartCubit.get(context).cartItems;
        return Scaffold(
          appBar: CustomAppBar(
            title: "Cart",
            isRoot: true,
            widget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: InkWell(
                onTap: () => Get.to(() => const AllReservationScreen()),
                child: Icon(
                  CupertinoIcons.doc_checkmark_fill,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: list.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/img2.png",
                          height: 200.h,
                          color: Colors.green,
                        ),
                        Gap(20.h),
                        Flexible(
                          child: Text(
                            "Your cart is empty please go back to main screen"
                                .tr,
                            textAlign: TextAlign.center,
                            style: AppFontStyle.primaryBold_14,
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Dismissible(
                          key: Key(list[index].name),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            var itemToRemove = list[index];
                            list.removeAt(index);

                            CartCubit.get(context).remove(itemToRemove);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${itemToRemove.name} ${"removed from cart".tr}'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Row(
                              children: [
                                Spacer(),
                                Icon(
                                  CupertinoIcons.trash,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          child: CartCard(trip: list[index]),
                        ),
                      );
                    },
                  ),
          ),
          bottomNavigationBar: list.isEmpty
              ? null
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 20.h,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.to(() => ReservationScreen(cartList: list));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("Checkout".tr, style: AppFontStyle.white_18),
                  ),
                ),
        );
      },
    );
  }
}

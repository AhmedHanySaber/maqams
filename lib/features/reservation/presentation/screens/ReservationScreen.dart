import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/validation/validation.dart';
import 'package:maqam_v2/core/widgets/snakbar.dart';
import 'package:maqam_v2/features/drawer/presentation/controller/drawer_cubit.dart';
import 'package:maqam_v2/features/reservation/models/reservation_model.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_state.dart';
import 'package:maqam_v2/features/reservation/presentation/controllers/reservation_cubit.dart';
import 'package:maqam_v2/features/reservation/presentation/controllers/reservation_state.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';
import '../../../../core/utils/colors.dart';

class ReservationScreen extends StatelessWidget {
  final List<TripModel> cartList;

  const ReservationScreen({super.key, required this.cartList});

  @override
  Widget build(BuildContext context) {
    final List<String> names = [];
    List<String> namesList() {
      for (var i in cartList) {
        names.add(i.name);
      }
      return names;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hotel Reservation',
          style: AppFontStyle.primary_22,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ReservationForm(
          cartList: namesList(),
          trips: cartList,
        ),
      ),
    );
  }
}

class ReservationForm extends StatefulWidget {
  final List<String> cartList;
  final List<TripModel> trips;

  const ReservationForm(
      {super.key, required this.cartList, required this.trips});

  @override
  State<StatefulWidget> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final _formKey = GlobalKey<FormState>();
  String? downloadUrl;
  double price = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReservationCubit.get(context).clearData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ReservationCubit, ReservationState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = ReservationCubit.get(context);
          for (var i in widget.trips) {
            price = price + i.price;
          }
          if (cubit.numberOfGuests > 2) {
            price = price * ((cubit.numberOfGuests - 1) * .9);
          }
          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: AppFontStyle.black_14,
                    prefixIcon: const Icon(Icons.person, color: Colors.green),
                    border: const OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.green),
                  validator: validateName,
                  onChanged: (value) {
                    cubit.setData("name", value);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: AppFontStyle.black_14,
                    prefixIcon: const Icon(Icons.email, color: Colors.green),
                    border: const OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.green),
                  validator: validateEmail,
                  onChanged: (value) {
                    cubit.setData("email", value);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: AppFontStyle.black_14,
                    prefixIcon: const Icon(Icons.phone, color: Colors.green),
                    border: const OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.green),
                  validator: validateFields,
                  onChanged: (value) {
                    cubit.setData("phoneNumber", value);
                  },
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Number of Guests',
                    style: AppFontStyle.primary_14,
                  ),
                  trailing: DropdownButton<int>(
                    value: cubit.numberOfGuests,
                    onChanged: (newValue) {
                      cubit.setData("numberOfGuests", newValue!);
                    },
                    items: List.generate(
                      10,
                      (index) => DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      ),
                    ),
                  ),
                ),
                SwitchListTile(
                  title: Text(
                    'Peak from Airport',
                    style: AppFontStyle.primary_14,
                  ),
                  value: cubit.peakFromAirport,
                  onChanged: (newValue) {
                    cubit.setData("peakFromAirport", newValue);
                  },
                ),
                if (cubit.peakFromAirport) ...[
                  ListTile(
                    title: Text(
                      'Number of Bags',
                      style: AppFontStyle.primary_14,
                    ),
                    trailing: DropdownButton<int>(
                      value: cubit.numberOfBags,
                      onChanged: (newValue) {
                        cubit.setData("numberOfBags", newValue!);
                      },
                      items: List.generate(
                        5,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text('$index'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Arrival Date:',
                    style: AppFontStyle.primaryBold_14
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (selectedDate != null) {
                        cubit.setData("arrivalDate", selectedDate);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      cubit.arrivalDate != null
                          ? '${cubit.arrivalDate!.day}/${cubit.arrivalDate!.month}/${cubit.arrivalDate!.year}'
                          : 'Select Date',
                      style: AppFontStyle.primary_14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  cubit.file != null
                      ? SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Image.file(cubit.file!))
                      : ElevatedButton(
                          onPressed: () async {
                            cubit.file = await cubit.pickImage();
                            final path = FirebaseStorage.instance
                                .ref("tickets")
                                .child(FirebaseAuth.instance.currentUser!.uid);

                            if (cubit.file != null) {
                              final taskSnapshot =
                                  await path.putFile(cubit.file!);
                              downloadUrl =
                                  await taskSnapshot.ref.getDownloadURL();
                            }
                            setState(() {});
                            print('Upload Ticket');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            'Upload Ticket',
                            style: AppFontStyle.primary_14,
                          ),
                        ),
                ],
                const SizedBox(height: 10),
                TextFormField(
                  decoration:  InputDecoration(
                    labelText: 'Comments',
                    labelStyle: AppFontStyle.black_14,
                    prefixIcon: const Icon(Icons.comment, color: Colors.green),
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: null,
                  style: const TextStyle(color: Colors.green),
                  onChanged: (value) => cubit.setData("comments", value),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
      bottomSheet: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cartCubit = CartCubit.get(context);
          final reservationCubit = ReservationCubit.get(context);
          final drawerCubit = DrawerCubit.get(context);
          return SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () async {
                print(price);
                if (_formKey.currentState!.validate()) {
                  final reservation = ReservationModel(
                    name: reservationCubit.name,
                    phoneNumber: reservationCubit.phoneNumber,
                    peakOfAirport: reservationCubit.peakFromAirport,
                    arrivalTime: reservationCubit.arrivalDate,
                    numberOfBags: reservationCubit.numberOfBags,
                    fileUrl: downloadUrl,
                    email: reservationCubit.email,
                    reserved: false,
                    uid: FirebaseAuth.instance.currentUser!.uid,
                    numberOfGuests: reservationCubit.numberOfGuests,
                    cartItems: widget.cartList,
                    comments: reservationCubit.comments,
                  );

                  final res =
                      await reservationCubit.addReservation(reservation);

                  if (res) {
                    for (var i in widget.trips) {
                      cartCubit.remove(i);
                      cartCubit.cartItems.clear();
                    }
                    showSnakbar(
                        context,
                        "reservation added successfully, we will contact you soon",
                        AppColors.primaryColor,
                        const Duration(seconds: 10));
                    Navigator.pop(context);
                    drawerCubit.currentIndex = 0;
                    reservationCubit.clearData();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'Submit',
                style: AppFontStyle.white_16,
              ),
            ),
          );
        },
      ),
    );
  }
}

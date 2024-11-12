import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maqam_v2/features/reservation/data/reservation_repo.dart';
import 'package:maqam_v2/features/reservation/presentation/controllers/reservation_state.dart';

import '../../models/reservation_model.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final ReservationRepo reservationRepo;

  ReservationCubit(this.reservationRepo) : super(ReservationInitial());

  File? file;
  String name = '';
  String email = '';
  String phoneNumber = '';
  int numberOfGuests = 1;
  int numberOfBags = 0;
  bool peakFromAirport = false;
  DateTime? arrivalDate;
  String comments = '';

  static ReservationCubit get(BuildContext context) => BlocProvider.of(context);

  Future<bool> addReservation(ReservationModel reservationModel) async {
    try {
      emit(AddLoading());
      final bool = await reservationRepo.addReservation(reservationModel);
      if (bool == true) {
        emit(AddSuccess());
        const SnackBar(
          content: Text('reservation submitted successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 10),
        );
        return true;
      } else {
        const SnackBar(
          content: Text('unable to add to reservation'),
          backgroundColor: Colors.red,
        );
        emit(AddError(error: "unable to add reservation"));
        return false;
      }
    } catch (e) {
      emit(AddError(error: "unable to add to reservation"));
      return false;
    }
  }

  Future<List<ReservationModel>> reservations() async {
    try {
      emit(GetReservationsLoading());
      final list = await reservationRepo.reservations();
      if (list.isNotEmpty) {
        emit(GetReservationsSuccess(reservations: list));
        return list;
      } else {
        emit(GetReservationsError(error: "No reservations found"));
        return [];
      }
    } catch (e) {
      emit(GetReservationsError(error: "unable to fetch to reservation"));
      return [];
    }
  }

  Future<List<ReservationModel>> acceptedReservations() async {
    try {
      emit(GetReservationsLoading());
      final list = await reservationRepo.acceptedReservations();
      if (list.isNotEmpty) {
        emit(GetReservationsSuccess(reservations: list));
        return list;
      } else {
        emit(GetReservationsError(error: "No reservations found"));
        return [];
      }
    } catch (e) {
      emit(GetReservationsError(error: "unable to fetch to reservation"));
      return [];
    }
  }

  Future<File?> pickImage() async {
    emit(PickFileLoading());
    // File? image;
    final picker = ImagePicker();
    final files = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
    );

    if (files != null) {
      file = File(files.path);
      emit(PickFileSuccess(file: file!));
    } else {
      emit(PickFileFailure(error: "file is empty"));
    }

    return file;
  }

  void setData(String field, dynamic value) {
    switch (field) {
      case 'name':
        name = value;
        break;
      case 'email':
        email = value;
        break;
      case 'phoneNumber':
        phoneNumber = value;
        break;
      case 'numberOfGuests':
        numberOfGuests = value;
        break;
      case 'peakFromAirport':
        peakFromAirport = value;
        break;
      case 'numberOfBags':
        numberOfBags = value;
        break;
      case 'arrivalDate':
        arrivalDate = value;
        break;
      case 'comments':
        comments = value;
        break;
    }
    emit(UpdateFieldState());
  }

  void clearData() {
    file = null;
    name = '';
    email = '';
    phoneNumber = '';
    numberOfGuests = 1;
    numberOfBags = 0;
    peakFromAirport = false;
    arrivalDate;
    comments = '';
  }
}

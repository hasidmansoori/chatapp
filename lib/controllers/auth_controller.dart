import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/services/firebase_service.dart';
import '../core/services/country_service.dart';
import '../models/country_model.dart';

class AuthController extends GetxController {
  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  final box = GetStorage();

  final countries = <Country>[].obs;
  final isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final selectedCountryCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    CountryService().fetchCountries().then((c) {
      countries.value = c;
      if (c.isNotEmpty) {
        selectedCountryCode.value = c.first.code; // Set default selected country
      }
    });
    FirebaseService().init(); // Ensure Firebase is initialized
  }

  void login() async {
    final email = emailCtl.text.trim();
    final password = passwordCtl.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter email and password');
      return;
    }

    isLoading.value = true;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      box.write('email', email);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Failed', e.message ?? 'Unknown error');
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  void register() async {
    final email = emailCtl.text.trim();
    final password = passwordCtl.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter email and password');
      return;
    }

    isLoading.value = true;

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      box.write('email', email);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Registration Failed', e.message ?? 'Unknown error');
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:devops_project/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class UserController extends GetxController {
  final List<User> users = [];

  void addUser(User user) {
    users.add(user);
  }

  final formKey = GlobalKey<FormState>();
  final uuid = const Uuid();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  String? selectedGender;
}

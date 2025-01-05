import 'package:devops_project/controller/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  _UserFormPageState createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final UserController controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Form'),
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildForm()),
            const SizedBox(width: 20),
            Expanded(flex: 3, child: _buildUserList()),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  } else if (value.length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(r'^\S+@\S+\.\S+\$').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Age is required';
                  } else if (int.tryParse(value) == null ||
                      int.parse(value) < 18) {
                    return 'Age must be 18 or older';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: controller.selectedGender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.selectedGender = value;
                },
                validator: (value) =>
                    value == null ? 'Gender is required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address is required';
                  } else if (value.length < 10) {
                    return 'Address must be at least 10 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black12,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text('Submit',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: controller.users.length,
      itemBuilder: (context, index) {
        final user = controller.users[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.lightBlue,
              child: Text(user.name[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white)),
            ),
            title: Text(user.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${user.email}'),
                Text('Age: ${user.age}'),
                Text('Gender: ${user.gender}'),
                Text('Address: ${user.address}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

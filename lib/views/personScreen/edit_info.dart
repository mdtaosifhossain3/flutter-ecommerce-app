import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/controllers/profile_controller.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/custom_button.dart';
import 'package:mini_ecommerce/global_widgets/text_widget.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({super.key});

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  final ProfileController controller = Get.put(ProfileController());

  final TextEditingController nameController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Edit Profile"),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const TextWidget(
                    label: "Update Name:",
                    fontWeight: FontWeight.bold,
                  ),
                  _buildTextField(
                    label: 'Change Name',
                    controller: nameController,
                    initialValue: controller.displayName.value,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    width: 1,
                    btnName: "Save Changes",
                    onClick: () {
                      controller.updateProfile(
                          context, nameController.text.trim());
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  const TextWidget(
                    label: "Update Password:",
                    fontWeight: FontWeight.bold,
                  ),
                  _buildTextField(
                    label: 'Current Password',
                    controller: _currentPasswordController,
                  ),
                  _buildTextField(
                    label: 'New Password',
                    controller: _newPasswordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    btnName: "Save Changes",
                    width: 1,
                    onClick: () {
                      controller.changePassword(context,
                          _currentPasswordController, _newPasswordController);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField({
  required String label,
  required TextEditingController controller,
  String? initialValue,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextField(
      controller: controller..text = initialValue ?? '',
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    ),
  );
}

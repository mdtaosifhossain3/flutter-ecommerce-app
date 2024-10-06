import 'package:flutter/material.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/custom_button.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 3.0; // Default rating value

  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      // Process the review submission here
      // For now, just showing a success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Review Submitted'),
          content:
              Text('Username: ${_userNameController.text}\nRating: $_rating\n'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Clear fields after submission
                _userNameController.clear();
                _reviewController.clear();
                setState(() {
                  _rating = 3.0;
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Add Review"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _reviewController,
                  decoration: const InputDecoration(
                    labelText: 'Review',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your review';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Rating: ${_rating.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 16),
                ),
                Slider(
                  value: _rating,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  label: _rating.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomButton(
                    btnName: "Submit Review",
                    onClick: _submitReview,
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

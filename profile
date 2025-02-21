import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? _imageFile;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _showFeedbackDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2a2a2a),
          title: const Text(
            'Send Feedback',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: _feedbackController,
            maxLines: 5,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Write your feedback here...',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                _feedbackController.clear();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                // Here you would typically send the feedback to your backend
                debugPrint('Feedback submitted: ${_feedbackController.text}');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thank you for your feedback!'),
                    backgroundColor: Colors.blue,
                  ),
                );
                Navigator.of(context).pop();
                _feedbackController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Account'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF1a1a1a),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Section
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    backgroundImage:
                        _imageFile != null ? FileImage(_imageFile!) : null,
                    child:
                        _imageFile == null
                            ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            )
                            : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bharath', // Replace with actual username from login
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),

            // Menu Items
            ListTile(
              leading: const Icon(Icons.feedback, color: Colors.blue),
              title: const Text(
                'Feedback',
                style: TextStyle(color: Colors.white),
              ),
              onTap: _showFeedbackDialog,
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.help, color: Colors.blue),
              title: const Text(
                'Get Help',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle get help section tap
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.lock_reset, color: Colors.blue),
              title: const Text(
                'Change Password',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle change password tap
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.explore, color: Colors.blue),
              title: const Text(
                'Explore More',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle explore more tap
              },
            ),
            const Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AboutUsPgae extends StatefulWidget {
  const AboutUsPgae({super.key});

  @override
  State<AboutUsPgae> createState() => _AboutUsPgaeState();
}

class _AboutUsPgaeState extends State<AboutUsPgae> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Our Company!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 192, 116, 2)),
              ),
              SizedBox(height: 16),
              Text(
                'Who We Are:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Our Company is a leading provider of homes, appartments and hotels rooms for the customers. We are dedicated to delivering high-quality rooms/services that exceed the expectations of our customers.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text(
                'Our Mission:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'At Our Company, our mission is to provide the best and comfortable rooms of hotels, homes and appartments to the customers. We aim to deliver high-quality rooms/services that exceed the expectations of our customers.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text(
                'Our Team:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We have a dedicated team of professionals who are passionate about what they do. Our team brings together diverse skills and expertise to ensure the success of our dealings with customers.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text(
                'Contact Us:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Have questions or want to get in touch with us? Feel free to contact us at +1 (123) 456-7890, or email us at staybooked@example.com. We would love to hear from you!',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

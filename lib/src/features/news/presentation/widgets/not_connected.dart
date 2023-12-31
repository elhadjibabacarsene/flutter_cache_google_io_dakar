import 'package:flutter/material.dart';
import 'package:flutter_gallery_cache/src/constants/colors/app_colors.dart';

class NotConnected extends StatelessWidget {
  const NotConnected({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.wifi_off,
            color: Colors.white,
          ),
          Text(
            'Vous êtes actuellement hors ligne. En attendant, \nrelisez les articles que nous avons gardés pour vous.',
            style: TextStyle(fontSize: 13, color: Colors.white),
          )
        ],
      ),
    );
  }
}

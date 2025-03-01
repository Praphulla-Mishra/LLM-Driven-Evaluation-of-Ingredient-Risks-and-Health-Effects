import 'package:flutter/material.dart';

class ModernButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  const ModernButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white), 
      label: Text(text, style: TextStyle(color: Colors.white)), 
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey[700],
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)), 
        elevation: 0, 
      ),
    );
  }
}
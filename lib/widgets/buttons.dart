import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomButtons extends StatelessWidget {
  final VoidCallback onTambahPressed;
  final VoidCallback onHitungPressed;
  final VoidCallback onKeluarPressed;

  CustomButtons({
    required this.onTambahPressed,
    required this.onHitungPressed,
    required this.onKeluarPressed,
  });

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ElevatedButton(
          onPressed: onTambahPressed,
          child: Text('Tambah'),
        ),
        ElevatedButton(
          onPressed: onHitungPressed,
          child: Text('Hitung'),
        ),
        ElevatedButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text('Keluar'),
        ),
      ],
    );
  }
}

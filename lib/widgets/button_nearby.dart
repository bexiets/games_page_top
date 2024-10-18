import 'package:flutter/material.dart';

class ButtonNearby extends StatelessWidget {
  const ButtonNearby({
    super.key,
    required this.isActiveNearby,
    required this.isActiveAll,
    required this.onPressed,
  });

  final ValueNotifier<bool> isActiveNearby;
  final ValueNotifier<bool> isActiveAll;
  final VoidCallback onPressed; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 64,
      child: TextButton(
        onPressed: onPressed,
        // () {
        //    isActiveNearby.value = true;
        //   isActiveAll.value = false;
         
        // },
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            shape:
                WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(color: isActiveNearby.value ? Colors.black : Colors.black26,)))),
        child: Center(
          child: Text('Рядом',
              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400), ),
        ),
      ),
    );
  }
}
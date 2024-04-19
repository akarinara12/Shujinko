import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final onPressed;
  final Widget child;
  final double radius;
  final Color buttonColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.radius,
    required this.buttonColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color(0xFF424242);


    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(top: 35, bottom: 15),
        child: SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius)
                    ),
                  side: const BorderSide(
                    color: borderColor, // Warna border (stroke)
                    width: 1.3, // Lebar border (stroke)
                  ),
                ),
                onPressed: onPressed,
                child: child,
                // child: Text(
                //   textButton,
                //   style: GoogleFonts.inriaSans(
                //       fontSize: 20,
                //       fontWeight: FontWeight.w800,
                //       color: Colors.white),
                // )
            )
        ),
      ),
    );
  }
}

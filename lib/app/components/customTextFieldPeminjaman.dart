import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldPeminjaman extends StatelessWidget {
  final bool obsureText;
  final String? InitialValue;
  final String labelText;
  final Widget? preficIcon;
  final Widget? surficeIcon;

  const CustomTextFieldPeminjaman({
    super.key,
    required this.obsureText,
    required this.InitialValue,
    required this.labelText,
    this.preficIcon,
    this.surficeIcon,
  });

  @override
  Widget build(BuildContext context) {
    const Color backgroundInput = Color(0xFFF8F8F8);
    const Color colorBorder = Color(0xFF020925);
    const Color background = Color(0xFF03010E);
    const Color colorText = Color(0xFFEA1818);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            labelText,
            style: GoogleFonts.inriaSans(
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),

          const SizedBox(
            height: 10,
          ),

          TextFormField(
            enabled: false,
            initialValue: InitialValue,
            style: GoogleFonts.inriaSans(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: background,
            ),
            obscureText: obsureText,
            decoration: InputDecoration(
              prefixIcon: preficIcon,
              fillColor: backgroundInput,
              suffixIcon: surficeIcon,
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorBorder.withOpacity(0.90),
                  ),
                  borderRadius: BorderRadius.circular(20.20)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorBorder.withOpacity(0.90),
                  ),
                  borderRadius: BorderRadius.circular(20.20)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorBorder.withOpacity(0.90),
                  ),
                  borderRadius: BorderRadius.circular(20.20)),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colorBorder.withOpacity(0.90),
                ),
                borderRadius: BorderRadius.circular(20.20),
              ),
              contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              errorStyle: GoogleFonts.inriaSans(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: colorText,
              ),
              hintStyle: GoogleFonts.inriaSans(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

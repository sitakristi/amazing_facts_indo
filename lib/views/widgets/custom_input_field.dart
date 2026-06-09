// lib/views/widgets/custom_input_field.dart
part of widgets;

class CustomInputField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final Widget? suffixIcon; // Ditambahkan untuk menampung tombol mata password

  const CustomInputField({
    super.key,
    required this.labelText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    const Color afGold = Color(0xFFFBC02D);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: afGold),
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: afGold)),
          prefixIcon: Icon(icon, color: afGold),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
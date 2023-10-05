import 'package:flutter/material.dart';
import 'package:money_manager/Comm/comHelper.dart';

// CustomTextFormField es un widget personalizado que encapsula un TextFormField
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller; // Controlador del campo de texto
  final String hintName; // Texto de sugerencia
  final IconData icon; // Icono que se muestra antes del campo de texto
  final bool
      isObscureText; // Indica si el texto debe ocultarse (por ejemplo, contraseñas)
  final TextInputType
      inputType; // Tipo de entrada del teclado (texto, número, correo electrónico, etc.)
  final bool isEnable; // Indica si el campo de texto está habilitado

  // Nuevos atributos para personalización del tema
  final OutlineInputBorder?
      customEnabledBorder; // Borde personalizado cuando está habilitado
  final OutlineInputBorder?
      customFocusedBorder; // Borde personalizado cuando está enfocado
  final Color? customFillColor; // Color de fondo personalizado
  final TextStyle? customTextStyle; // Estilo de texto personalizado
  final String? Function(String? value)?
      customValidator; // Validador personalizado

  // Constructor de CustomTextFormField
  CustomTextFormField({
    required this.controller,
    required this.hintName,
    required this.icon,
    this.isObscureText = false,
    this.inputType = TextInputType.text,
    this.isEnable = true,
    this.customValidator, // Parámetro opcional para validación personalizada
    // Parámetros opcionales para personalización del tema
    this.customEnabledBorder,
    this.customFocusedBorder,
    this.customFillColor,
    this.customTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Definir los estilos y decoraciones personalizados o usar los valores predeterminados
    final OutlineInputBorder enabledBorder = customEnabledBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.transparent),
        );

    final OutlineInputBorder focusedBorder = customFocusedBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
              color: Colors.blue.shade300), // Color de borde enfocado más claro
        );

    final Color fillColor = customFillColor ?? Colors.white;
    final TextStyle textStyle = customTextStyle ?? TextStyle();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        enabled: isEnable,
        keyboardType: inputType,
        validator: (value) {
          // Utiliza el validador personalizado si se proporciona, de lo contrario, usa la validación predeterminada
          if (customValidator != null) {
            return customValidator!(value);
          }

          // Validación predeterminada
          if (value == null || value.isEmpty) {
            return "Please Enter $hintName";
          }

          if (hintName == "Email" && !validateEmail(value)) {
            return "Please Enter Valid email";
          }

          return null;
        },
        decoration: InputDecoration(
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          prefixIcon: Icon(icon),
          hintText: hintName,
          labelText: hintName,
          fillColor: fillColor,
          filled: true,
        ),
        style: textStyle,
      ),
    );
  }
}

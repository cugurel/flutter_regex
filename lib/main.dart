import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'luhn_check.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Regex Form",
      home: RegexForm(),
    );
  }
}

class RegexForm extends StatefulWidget {
  RegexForm({Key? key}) : super(key: key);

  @override
  _RegexFormState createState() => _RegexFormState();
}

class _RegexFormState extends State<RegexForm> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController creditCardController = TextEditingController();

  var phoneMask = MaskTextInputFormatter(
      mask: '+9 (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
  var creditMask = MaskTextInputFormatter(
      mask: '####-####-####-####', filter: {"#": RegExp(r'[0-9]')});

  final userNameValid = RegExp(r'^[a-z0-9]{5,12}$', caseSensitive: false);
  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Kullanıcı Kayıt",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: userNameController,
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: "Kullanıcı Adı: ",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: " Email: ",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneController,
              inputFormatters: [phoneMask],
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                hintText: "Telefon No: ",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: creditCardController,
              inputFormatters: [creditMask],
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.credit_card),
                hintText: "Kredi Kart No: ",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                  onPressed: () {
                    if (validateCardNumWithLuhnAlgorithm(
                        creditMask.getUnmaskedText().toString())) {
                      print("Kredi Kartı geçerlidir.");
                    } else {
                      print("Kredi Kartı geçerli değil.");
                    }
                  },
                  child: const Text("GÖNDER")),
            )
          ],
        ),
      ),
    );
  }
}

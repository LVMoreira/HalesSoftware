import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hales_gps/pages/dashboard_page.dart';
import 'package:hales_gps/theme.dart';
import 'maps_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _login() {
    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha ambos os campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,  // Cor de fundo do body
      body: Padding(
        padding: EdgeInsets.all(15),  // Padding geral para toda a tela
        child: Row(
          children: [
            // Seção do formulário
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                  color: AppTheme.primaryColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logotipo
                        Image.asset(
                          "assets/brand/hales_logo.png",
                          height: 50,
                        ),
                        SizedBox(height: 50),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppTheme.greenPastel,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "LOGIN",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.greenPastelText,
                            ),
                          ),
                        ),
                        SizedBox(height: 15), // Título "Welcome!"
                        Text(
                          "Welcome!",
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Welcome to Hales! Login with your user and password. If you don't have an account, please Sign Up.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Campo de Username
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            filled: true,
                            fillColor: Colors.black,
                            labelStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 10),

                        // Campo de Senha
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            filled: true,
                            fillColor: Colors.black,
                            labelStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.white, size: 20),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 20),

                        // Botão de Login
                        ElevatedButton(
                          onPressed: _login,
                          child: Text('Entrar' ,
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.blueLogo,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),

                        SizedBox(height: 20),
                        Text("OU", 
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 20),

                        // Botões Sociais
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.g_translate, color: Colors.white),
                              onPressed: () {},
                            ),
                            SizedBox(width: 10),  // Gap entre os botões
                            IconButton(
                              icon: Icon(Icons.apple, color: Colors.white),
                              onPressed: () {},
                            ),
                            SizedBox(width: 10),  // Gap entre os botões
                            IconButton(
                              icon: Icon(Icons.discord, color: Colors.white),
                              onPressed: () {},
                            ),
                            SizedBox(width: 10),  // Gap entre os botões
                            IconButton(
                              icon: Icon(Icons.wallet, color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 15),
            // Seção da Imagem com cantos arredondados
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/background.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

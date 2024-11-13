import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: CalculadoraDeber());
  }
}

class CalculadoraDeber extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculadoraDeber> {
  String displayText = '0';

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () => calculadora(buttonText),
        child: Text(
          "$buttonText",
          style: TextStyle(fontSize: 26, color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEADDCA),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    displayText,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFf5d6d7e),
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("AC", Color(0xFfc0392b), Color(0xFFeaecee)),
                buildButton("+/-", Color(0XFFf8c471), Color(0xFf5d6d7e)),
                buildButton("%", Color(0XFFf8c471), Color(0xFF5d6d7e)),
                buildButton("⌫", Color(0xFfc0392b), Color(0xFFeaecee)),
                buildButton("/", Color(0XFff8c471), Color(0xFf5d6d7e)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("7", Color(0xFF34495e), Colors.white),
                buildButton("8", Color(0xFF6A9AB0), Colors.white),
                buildButton("9", Color(0xFF34495e), Colors.white),
                buildButton("x", Color(0XFff8c471), Color(0xFf5d6d7e)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("4", Color(0xFf34495e), Colors.white),
                buildButton("5", Color(0xFF6A9AB0), Colors.white),
                buildButton("6", Color(0xFF34495e), Colors.white),
                buildButton("-", Color(0XFFf8c471), Color(0xFf5d6d7e)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("1", Color(0xFF34495e), Colors.white),
                buildButton("2", Color(0xFF6A9AB0), Colors.white),
                buildButton("3", Color(0xFf34495e), Colors.white),
                buildButton("+", Color(0XFFf8c471), Color(0xFf5d6d7e)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => calculadora("0"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF85929e),
                      padding: EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                    child: buildButton(".", Color(0xFF85929e), Colors.white)),
                Expanded(
                    child: buildButton("=", Color(0xFfc0392b), Colors.white)),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String resultado = '';
  double numUno = 0;
  double numDos = 0;
  String resultadoFinal = '0';
  String operacion = '';
  String operacionAnterior = '';

  void calculadora(String buttonText) {
    if (buttonText == 'AC') {
      displayText = '0';
      resultado = '';
      numUno = 0;
      numDos = 0;
      resultadoFinal = '0';
      operacion = '';
      operacionAnterior = '';
    } else if (buttonText == '⌫') {
      if (resultado.isNotEmpty) {
        resultado = resultado.substring(0, resultado.length - 1);
        if (resultado.isEmpty) {
          resultado = '0';
        }
        resultadoFinal = resultado;
      }
    } else if (operacion == '=' && buttonText == '=') {
      if (operacionAnterior == '+') resultadoFinal = sumar();
      if (operacionAnterior == '-') resultadoFinal = restar();
      if (operacionAnterior == 'x') resultadoFinal = multiplicar();
      if (operacionAnterior == '/') resultadoFinal = dividir();
    } else if (['+', '-', 'x', '/', '='].contains(buttonText)) {
      if (numUno == 0) {
        numUno = double.parse(resultado);
      } else {
        numDos = double.parse(resultado);
      }

      if (operacion == '+') resultadoFinal = sumar();
      if (operacion == '-') resultadoFinal = restar();
      if (operacion == 'x') resultadoFinal = multiplicar();
      if (operacion == '/') resultadoFinal = dividir();

      operacionAnterior = operacion;
      operacion = buttonText;
      resultado = '';
    } else if (buttonText == '%') {
      if (resultado.isNotEmpty) {
        double valorActual = double.parse(resultado);
        resultado = (valorActual / 100).toString();
      } else if (numUno != 0) {
        resultado = (numUno / 100).toString();
      }
      resultadoFinal = formatoDecimal(resultado);
    } else if (buttonText == '.') {
      if (!resultado.contains('.')) resultado = resultado + '.';
      resultadoFinal = resultado;
    } else if (buttonText == '+/-') {
      resultado =
          resultado.startsWith('-') ? resultado.substring(1) : '-$resultado';
      resultadoFinal = resultado;
    } else {
      resultado = resultado + buttonText;
      resultadoFinal = resultado;
    }
    setState(() {
      displayText = resultadoFinal;
    });
  }

  String formatoDecimal(String resultado) {
    if (resultado.contains('.')) {
      List<String> reducirDecimal = resultado.split('.');
      if (int.parse(reducirDecimal[1]) == 0) return reducirDecimal[0];
    }
    return resultado;
  }

  String sumar() {
    resultado = (numUno + numDos).toString();
    numUno = double.parse(resultado);
    return formatoDecimal(resultado);
  }

  String restar() {
    resultado = (numUno - numDos).toString();
    numUno = double.parse(resultado);
    return formatoDecimal(resultado);
  }

  String multiplicar() {
    resultado = (numUno * numDos).toString();
    numUno = double.parse(resultado);
    return formatoDecimal(resultado);
  }

  String dividir() {
    resultado = (numUno / numDos).toString();
    numUno = double.parse(resultado);
    return formatoDecimal(resultado);
  }
}

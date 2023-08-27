import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ipscamv2/cod_utils/image_picker_class.dart';
import 'package:ipscamv2/cod_utils/image_cropper_page.dart';

void main() {
  runApp(inicio());
}

class inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inicio',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: PantallaInicio(),
    );
  }
}

class PantallaInicio extends StatelessWidget {

  final TextEditingController _cod_placa = TextEditingController(text: '');
  late BuildContext context_p;

  @override
  Widget build(BuildContext context) {
    context_p=context;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            // Contenedor superior azul con bordes redondeados en la parte inferior
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 1, 147, 244), // Color celeste personalizado
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            padding: EdgeInsets.fromLTRB(16, 40, 16, 0), // Margen superior
            child: Column(
              children: [
                Text(
                  'Inicio', // Título
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20), // Espacio entre título y buscador
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20), // Espacio inferior
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Numero de Placa',
                            border:
                                OutlineInputBorder(), // Contorno del buscador
                          ),
                          controller: _cod_placa,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        color: Color(0xFF3498db), // Color celeste personalizado
                        onPressed: () {
                          // Realizar búsqueda
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            _buildCard(
                Icons.photo_camera_back_outlined,
                'Tome una fotografia de su vehiculo y escanee el código de la placa',
                'Escanear Ahora',
                () {
                  photoScam(1);
                },
                iconColor: Color.fromARGB(255, 0, 26, 196), // Color del Icono
                buttonColor:
                    Color.fromARGB(255, 0, 119, 255), // Color del Boton
              ),

              _buildCard(
                Icons.image_search,
                'Seleccione una fotografia de su galeria y escanee el código de placa.',
                'Buscar Ahora',
                () {
                  photoScam(2);
                },
                iconColor: Color.fromARGB(255, 89, 159, 182), // Color del Icono
                buttonColor:
                    Color.fromARGB(255, 46, 204, 193), // Color del Boton
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Construye un Card personalizado
  Widget _buildCard(
      IconData icon, String title, String buttonText, VoidCallback onPressed,
      {Color? iconColor, Color? buttonColor} // Colores personalizables
      ) {
    return Expanded(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                icon,
                size: 80,
                color: iconColor ??
                    Color(0xFF3498db), // Color celeste personalizado
              ),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  primary: buttonColor ??
                      Color(0xFF3498db), // Color celeste personalizado
                  minimumSize:
                      Size(double.infinity, 50), // Ancho y alto del botón
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16, // Tamaño de texto personalizado
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void photoScam(int i) {
    if (i == 1) {
      pickImage(source: ImageSource.camera).then((value) {
        if (value != '') {
          imageCropperView(value, context_p).then((value) {
            if (value != '') {
              final InputImage inputImage = InputImage.fromFilePath(value);
              processImage(inputImage);
            }
          });
        }
      });
    } else {
      pickImage(source: ImageSource.gallery).then((value) {
        if (value != '') {
          imageCropperView(value, context_p).then((value) {
            if (value != '') {
              final InputImage inputImage = InputImage.fromFilePath(value);
              processImage(inputImage);
            }
          });
        }
      });
    }
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RecognizedText recognizedText =
    await textRecognizer.processImage(image);

    //texto = "${recognizedText.text}";
    _cod_placa.text=recognizedText.text;

  }
}

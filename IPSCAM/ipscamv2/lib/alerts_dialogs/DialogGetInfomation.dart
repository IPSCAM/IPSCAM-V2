import 'dart:convert';

import 'package:desing_ipscamv2/ContenidoConsulta.dart';
import 'package:flutter/material.dart';

import '../cod_utils/HttpGetRequest.dart';

class DialogGetInformation extends StatefulWidget {
  final String code;

  const DialogGetInformation({required this.code, super.key});

  @override
  _DialogGetInformationState createState() => _DialogGetInformationState();
}

class _DialogGetInformationState extends State<DialogGetInformation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller_animation;
  late bool isLoading = true;
  late bool sFoot = false;
  late String titulo;
  late String inf;
  late int icon_state_selec;

  List<IconData> icon_state = [
    Icons.signal_wifi_bad_rounded, //Sin conexion
    Icons.warning_amber_rounded, //Informacion no encontrada
    Icons.cloud_off_rounded,
  ];

  @override
  void initState() {
    super.initState();
    controller_animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    titulo = 'Obteniendo información';
    inf = 'Estamos obteniendo la información, por favor espere...';
    icon_state_selec = 0;

    getRequest();
  }

  void cambiarTitulo(String tit) {
    setState(() {
      titulo = tit;
    });
  }

  void cambiarInf(String info) {
    setState(() {
      inf = info;
    });
  }

  void cambiarIcon(int ic) {
    setState(() {
      icon_state_selec = ic;
    });
  }

  void mostrarFoot(bool sh) {
    setState(() {
      sFoot = sh;
    });
  }

  Future<void> getRequest() async {
    HttpGetRequest httpRequest = HttpGetRequest();
    String url =
        'https://apex.oracle.com/pls/apex/is1_project/consulta/${widget.code}';
    String? result = await httpRequest.fetchUrl(url);
    if (result == null || result.isEmpty) {
      sendDialogo(
          "Error de conexion",
          "Fallo a conexion con el servidor, por favor verifique que se encuentre en linea.",
          2);
    }
    if (result != null) {
      analizar_jSon(result);
    } else {}
  }

  void sendDialogo(String tit, String info, int icono) {
    cambiarTitulo(tit);
    cambiarInf(info);
    cambiarIcon(icono);
    mostrarFoot(true);
    isLoading = false;
    //dispose();
  }

  void analizar_jSon(String result) {
    try {
      Map<String, dynamic> apexObject = json.decode(result);
      List<dynamic> apexItems = apexObject["items"];

      if (apexItems.isNotEmpty) {
        Map<String, dynamic> json = apexItems[0];

        if (json.length > 0) {
          Navigator.of(context).pop(); //Cierro el dialog

          //Ejecutamos pantalla para mostrar los datos.
          Navigator.push(
            context,
            MaterialPageRoute(
              //builder: (context) => MostrarDatos(json: json),
              builder: (context) => ContenidoConsulta(json: json),
            ),
          );
        } else {
          sendDialogo("Datos no encontrados",
              "No se encontro el numero de placa ingresado.", 1);
        }
      }
    } catch (e) {
      sendDialogo("Datos no encontrados",
          "No se encontro el numero de placa ingresado.", 1);
      //cambiarInf('No se pudo analizar el jSON');
      // Manejar errores de análisis JSON aquí
      //print("Error al analizar JSON: $e");
    }
  }

  @override
  void dispose() {
    controller_animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      titulo,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: controller_animation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: controller_animation.value *
                              2 *
                              3.1415926535897932,
                          child: Visibility(
                            visible: isLoading,
                            child: Image.asset(
                              'assets/images/loading.png',
                              width: 32,
                              height: 32,
                              color: Colors.indigo,
                            ),
                          ),
                        );
                      },
                    ),
                    Visibility(
                      visible: !isLoading,
                      child: Icon(
                        icon_state[icon_state_selec],
                        size: 32,
                        color: Colors.black45,
                      ),
                    )
                  ],
                )
              ],
            ),
            Text(
              inf,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: sFoot,
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      'Cerrar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

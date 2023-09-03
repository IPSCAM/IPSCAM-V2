import 'package:flutter/material.dart';


class ContenidoConsulta extends StatelessWidget {
  final Map<String, dynamic> json;
  ContenidoConsulta({required this.json});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contenido',
      home: Scaffold(
        body: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 4, 46, 73),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 30, // Añade margen superior
                    left: 125,
                    child: Container(
                      width: 150,
                      height: 100,
                      child: ClipRect(
                        child: Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Color de sombra
                                offset:
                                Offset(5, 40), // Desplazamiento de sombra
                                blurRadius: 6, // Radio de difuminado
                                spreadRadius: 2, // Extensión de sombra
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/placa.jpg',
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context); // Regresar a la pantalla anterior
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 145, 148, 150),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(left: 8),
                        padding: EdgeInsets.all(8),
                        width: 50,
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    top: 30,
                    child: Center(
                      child: Text(
                        '${json["placa"]}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Tabla 1: Datos de Vehículo
                        _buildTable('Datos de Vehículo', [
                          _buildTableRow('Placa', '${json["placa"]}'),
                          _buildTableRow('Marca', '${json["marca"]}'),
                          _buildTableRow('Modelo', '${json["modelo"]}'),
                          _buildTableRow('Color', '${json["color"]}'),
                          _buildTableRow('Motor', '${json["motor"]}'),
                          _buildTableRow('VIN', '${json["vin"]}'),
                        ]),
                        SizedBox(height: 20),
                        // Tabla 2: Datos de Financiera
                        _buildTable(
                            'Datos de Financiera',
                            [
                              _buildTableRow('Nombre', '${json["financiera"]}'),
                              _buildTableRow('No. Préstamo', '${json["no_prestamo"]}'),
                              _buildTableRow('No. Perfil', 'ValorPerfil'),
                              _buildTableRow('Nombre Cliente', '${json["cliente"]}'),
                              _buildTableRow('Estado', '${json["estado"]}'),
                              _buildTableRow('Días de mora', '${json["dias_mora"]}'),
                              _buildTableRow('Monto Adeudado', '${json["montoadeudato"]}'),
                            ],
                            color: Color(0xFFFCE4EC)),
                        SizedBox(height: 20),
                        // Icono de contacto y texto de contacto
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.contact_phone),
                            SizedBox(width: 10),
                            Text('Contacto: +504 27820036'),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
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

  Widget _buildTable(String title, List<TableRow> rows, {Color? color}) {
    bool isEven = false;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTableTitle(title),
          Table(
            border: TableBorder.symmetric(
              inside: BorderSide(width: 1, color: Colors.transparent),
            ),
            children: rows.map((row) {
              isEven = !isEven;
              return TableRow(
                decoration: BoxDecoration(
                  color: isEven ? color ?? Color(0xFFE3F2FD) : Colors.white,
                ),
                children: row.children,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTableTitle(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value), // Asigna el valor adecuado aquí
          ),
        ),
      ],
    );
  }
}

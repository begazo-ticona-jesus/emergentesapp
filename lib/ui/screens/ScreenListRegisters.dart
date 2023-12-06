import 'package:flutter/material.dart';

class ScreenRegisters extends StatelessWidget {
  const ScreenRegisters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de datos simulados (puedes reemplazarlo con tus propios datos)
    List<String> registros = List.generate(100, (index) => 'Registro ${index + 1}');

    // Número de elementos por página
    int elementosPorPagina = 10;

    return Scaffold(
      appBar: AppBar(
        title: Text('Registers Screen'),
      ),
      body: ListView.builder(
        itemCount: (registros.length / elementosPorPagina).ceil(),
        itemBuilder: (context, pageIndex) {
          int startIndex = pageIndex * elementosPorPagina;
          int endIndex = (pageIndex + 1) * elementosPorPagina;
          endIndex = endIndex > registros.length ? registros.length : endIndex;

          List<String> registrosPagina = registros.sublist(startIndex, endIndex);

          return Card(
            child: Column(
              children: registrosPagina.map((registro) => ListTile(title: Text(registro))).toList(),
            ),
          );
        },
      ),
    );
  }
}
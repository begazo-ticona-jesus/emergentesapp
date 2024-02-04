// ignore_for_file: file_names
import 'package:emergentesapp/domain/models/dataModel.dart';
import 'package:emergentesapp/infraestructure/repository/dynamoRepository.dart';
import 'package:emergentesapp/presentation/screens/listRegisters/widgets/LineChart.dart';
import 'package:flutter/material.dart';

class ScreenRegisters extends StatefulWidget {
  const ScreenRegisters({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScreenRegistersState createState() => _ScreenRegistersState();
}

class _ScreenRegistersState extends State<ScreenRegisters> {
  final PageController _pageController = PageController();
  List<DataModel> registros = [];
  int elementosPorPagina = 10;
  List<String> dataChart = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final dataRepository = DynamoRepositoryImpl(); // Puedes inyectar esto desde fuera según tus necesidades
      final List<DataModel> fetchedData = await dataRepository.getDataList();
      List<String> dataChartClasificada = fetchedData.map((data) {
        return clasificarLuz(data.light);
      }).toList();

      setState(() {
        registros = fetchedData;
        dataChart = dataChartClasificada;
      });

    } catch (e) {
      print('Error: $e');
    }
  }

  String clasificarLuz(int valor) {
    if (valor < 300) {
      return 'bajo';
    } else if (valor <= 700) {
      return 'medio';
    } else {
      return 'alto';
    }
  }

  IconData getIconData(int valor) {
    if (valor < 300) {
      return Icons.wb_sunny_outlined;
    } else if (valor <= 700) {
      return Icons.sunny_snowing;
    } else {
      return Icons.sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 70, bottom: 10),
          child: Text(
            'Listado de registros',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                shadows: [ Shadow( color: Color(0xFF343764), offset: Offset(2.0, 2.0), blurRadius: 3.0, ),],
              ),
          ),
        ),

        LineChartSample(data: dataChart),

        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: (registros.length / elementosPorPagina).ceil(),
            itemBuilder: (context, pageIndex) {
              int startIndex = pageIndex * elementosPorPagina;
              int endIndex = (pageIndex + 1) * elementosPorPagina;
              endIndex = endIndex > registros.length ? registros.length : endIndex;

              List<DataModel> registrosPagina = registros.sublist(startIndex, endIndex);

              return ListView(
                children: registrosPagina.map((data) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: ListTile(
                      title: Text('Movimiento: ${data.motion == 0 ? 'NO' : 'SI '},  \tLuz: ${data.light}'),
                      trailing: Icon(getIconData(data.light))
                    ),
                  ),
                )).toList(),
              );
            },
          ),
        ),

        // Añadir botones de navegación
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_pageController.page != 0) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Color de fondo
                ),
                child: const Text(
                  'Anterior',
                  style: TextStyle(color: Color(0xFF343764)),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  if (_pageController.page != (registros.length / elementosPorPagina).ceil() - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Color de fondo
                ),
                child: const Text(
                  'Siguiente',
                  style: TextStyle(color: Color(0xFF343764)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

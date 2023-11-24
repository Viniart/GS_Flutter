// ReesultPage é a tela que exibe o resultado do calculo de calorias diárias6
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:gs_2/api/fitness_calculator_api.dart';
import 'package:gs_2/models/daily_calorie.dart';

class ResultPage extends StatefulWidget {
  final String age;
  final String genre;
  final String weight;
  final String height;
  final String activityLevel;

  const ResultPage({
    super.key,
    required this.age,
    required this.genre,
    required this.weight,
    required this.height,
    required this.activityLevel,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dailyCalorieFuture = FitnessCalculatorApi().findDailyCalories(
        widget.age,
        widget.genre,
        widget.weight,
        widget.height,
        widget.activityLevel);

    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorias diárias'),
      ),
      // Remove o Widgt de center e add o FutureBuilder para exibir o resultado
      body: FutureBuilder<DailyCalorie?>(
        future: dailyCalorieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao carregar daily calories"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isUndefinedOrNull) {
            return const Center(
              child: Text("Nenhum daily calorie encontrado"),
            );
          } else {
            final dailyCalorie = snapshot.data!;
            return _buildResult(dailyCalorie);
          }
        },
      ),
    );
  }

  // Utilize o metodo abaixo para criar o corpo da tela de resultado
  _buildResult(DailyCalorie calorie) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Metabolismo basal'),
          subtitle: Text(
            '${calorie.bMR}',
          ),
        ),
        ListTile(
          title: const Text('Manter o peso'),
          subtitle: Text(
            '${calorie.goals?.maintainWeight}',
          ),
        ),
        ListTile(
          title: Text(
              'Perda leve de peso ${calorie.goals?.mildWeightLoss?.lossWeight}'),
          subtitle: Text(
            '${calorie.goals?.mildWeightLoss?.calory}',
          ),
        ),
        ListTile(
          title: Text('Perda de peso ${calorie.goals?.weightLoss?.lossWeight}'),
          subtitle: Text(
            '${calorie.goals?.weightLoss?.calory}',
          ),
        ),
        ListTile(
          title: Text(
              'Perda extrema de peso ${calorie.goals?.extremeWeightLoss?.lossWeight}'),
          subtitle: Text(
            '${calorie.goals?.extremeWeightLoss?.calory}',
          ),
        ),
        ListTile(
          title: Text(
              'Ganho leve de peso ${calorie.goals?.mildWeightGain?.gainWeight}'),
          subtitle: Text(
            '${calorie.goals?.mildWeightGain?.calory}',
          ),
        ),
        ListTile(
          title: Text('Ganho de peso ${calorie.goals?.weightGain?.gainWeight}'),
          subtitle: Text(
            '${calorie.goals?.weightGain?.calory}',
          ),
        ),
        ListTile(
          title: Text(
              'Ganho extremo de peso ${calorie.goals?.extremeWeightGain?.gainWeight}'),
          subtitle: Text(
            '${calorie.goals?.extremeWeightGain?.calory}',
          ),
        ),
      ],
    );
  }
}

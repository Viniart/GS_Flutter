import 'package:flutter/material.dart';
import 'package:gs_2/models/daily_calorie.dart';
import 'package:gs_2/pages/result_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _age = new TextEditingController();
  String _gender = "";
  final TextEditingController _weight = new TextEditingController();
  final TextEditingController _height = new TextEditingController();
  String _activityLevel = "";

  DailyCalorie? dailyCalorie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorias diárias'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildAge(),
                const SizedBox(height: 20),
                _buildGender(),
                const SizedBox(height: 20),
                _buildWeight(),
                const SizedBox(height: 20),
                _buildHeight(),
                const SizedBox(height: 20),
                _buildActivityLevel(),
                const SizedBox(height: 20),
                _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAge() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _age,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "O valor é obrigatório";
        }

        if (int.tryParse(value)! < 0) {
          return 'O valor deve ser positivo';
        }

        if (int.tryParse(value)! > 80) {
          return "O valor deve ser menor que 80";
        }

        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Informe sua idade',
        labelText: 'Idade',
        border: OutlineInputBorder(),
      ),
    );
  }

  _buildGender() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        hintText: 'Informe seu gênero',
        labelText: 'Gênero',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "O valor é obrigatório";
        }

        if (value != "male" && value != "female") {
          return "Opção inválida";
        }

        return null;
      },
      items: const [
        DropdownMenuItem(
          value: 'male',
          child: Text('Masculino'),
        ),
        DropdownMenuItem(
          value: 'female',
          child: Text('Feminino'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _gender = value!;
        });
      },
    );
  }

  _buildWeight() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "O valor é obrigatório";
        }

        if (int.tryParse(value)! < 40 || int.tryParse(value)! > 160) {
          return "O valor deve ser entre 40 e 160";
        }

        return null;
      },
      controller: _weight,
      decoration: const InputDecoration(
        hintText: 'Informe seu peso (kg)',
        labelText: 'Peso',
        border: OutlineInputBorder(),
      ),
    );
  }

  _buildHeight() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "O valor é obrigatório";
        }

        if (int.tryParse(value)! < 130 || int.tryParse(value)! > 230) {
          return "O valor deve ser entre 130 e 230";
        }

        return null;
      },
      controller: _height,
      decoration: const InputDecoration(
        hintText: 'Informe sua altura (cm)',
        labelText: 'Altura',
        border: OutlineInputBorder(),
      ),
    );
  }

  _buildActivityLevel() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        hintText: 'Informe seu nível de atividade física',
        labelText: 'Nível de atividade',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "O valor é obrigatório";
        }

        return null;
      },
      items: const [
        DropdownMenuItem(
          value: 'level_1',
          child: Text('Sedentário: pouco ou nenhum exercício'),
        ),
        DropdownMenuItem(
          value: 'level_2',
          child: Text('Exercício 1-3 vezes/semana'),
        ),
        DropdownMenuItem(
          value: 'level_3',
          child: Text('Exercício 4-5 vezes/semana'),
        ),
        DropdownMenuItem(
          value: 'level_4',
          child: Text('Exercício diário ou exercício intenso 3-4 vezes/semana'),
        ),
        DropdownMenuItem(
          value: 'level_5',
          child: Text('Exercício intenso 6-7 vezes/semana'),
        ),
        DropdownMenuItem(
          value: 'level_6',
          child:
              Text('Exercício muito intenso diariamente, ou trabalho físico'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _activityLevel = value!;
        });
      },
    );
  }

  SizedBox _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Calcular',
            style: TextStyle(fontSize: 20),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ResultPage(
                  age: _age.text,
                  genre: _gender,
                  weight: _weight.text,
                  height: _height.text,
                  activityLevel: _activityLevel,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

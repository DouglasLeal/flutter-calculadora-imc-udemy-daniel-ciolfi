import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String infoText = "Informe seus dados.";

  void limparControllers() {
    pesoController.clear();
    alturaController.clear();

    setState(() {
      infoText = "Informe seus dados.";
      formKey = GlobalKey<FormState>();
    });
  }

  void calcularIMC() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;

    double imc = peso / (altura * altura);

    setState(() {
      infoText = "IMC: ${imc.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: limparControllers,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                controller: pesoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu peso!";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 24),
              ),
              TextFormField(
                controller: alturaController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua altura!";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 24),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 32),
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      calcularIMC();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Text(
                    "Calcular",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}

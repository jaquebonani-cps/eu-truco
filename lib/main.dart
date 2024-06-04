import 'package:eu_truco/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final database = FirebaseDatabase.instance;
  final ref = database.ref("alunos/756");

  ref.set({
    "nome": "Jaqueline",
    "email": "jaque@dominio.com",
    "notas": [
      {
        "componente": "PAMI",
        "nota": "10",
      },
      {
        "componente": "TCC",
        "nota": "9.5",
      }
    ],
    "dadosSensiveis": {
      "religiao": "religiaoX",
      "filiacaoPolitica": "partidoY",
    }
  });

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late String nome = "";

  @override
  Widget build(BuildContext context) {
    final alunoRef = FirebaseDatabase.instance.ref("alunos/756");
    alunoRef.onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        nome = data["nome"];
      });
    });
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

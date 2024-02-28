import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Cards/card_goal.dart';
import 'package:flutter/material.dart';

class GoalsSection extends StatefulWidget {
  const GoalsSection({super.key});

  @override
  State<GoalsSection> createState() => _GoalsSectionState();
}

class _GoalsSectionState extends State<GoalsSection> {
  final Mediator mediator = Mediator();
  final CorridaDaoDb _corridaDaoDb = CorridaDaoDb();
  final ServicoDaoDb _servicoDaoDb = ServicoDaoDb();

  @override
  initState() {
    super.initState();
    carregaListas().then((e) {
      mediator.calculaCustoHoje();
      mediator.calculaRecebimentosHoje();
    });
  }

  carregaListas() async {
    mediator.listaDeCorridas = await _corridaDaoDb.listar();
    mediator.listaDeServicos = await _servicoDaoDb.listar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                'Metas:',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: UtilsColors.corTextoEmDestaqueNosWidgets,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          children: [
            CardGoal(
              titulo: 'Hoje',
              saldo: mediator.calculaRecebimentosHoje() -
                  mediator.calculaCustoHoje(),
              meta: 350, //valores devem ser variaveis de acordo com o banco
              corDoIndicadorDeProgresso: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            CardGoal(
              titulo: 'Esta Semana',
              saldo: mediator.calculaRecebimentosDestaSemana() -
                  mediator
                      .calculaCustoDestaSemana(), //valores devem ser variaveis de acordo com o banco
              meta: 2100, //valores devem ser variaveis de acordo com o banco
              corDoIndicadorDeProgresso: Colors.purple,
            ),
            const SizedBox(
              height: 10,
            ),
            CardGoal(
              titulo: 'Este Mês',
              saldo: mediator.calculaRecebimentosDesteMes() -
                  mediator
                      .calculaCustoDesteMes(), //valores devem ser variaveis de acordo com o banco
              meta: 8400, //valores devem ser variaveis de acordo com o banco
              corDoIndicadorDeProgresso: Colors.teal,
            ),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Cards/card_summary.dart';
import 'package:flutter/material.dart';

class SummarySection extends StatefulWidget {
  const SummarySection({super.key});

  @override
  State<SummarySection> createState() => _SummarySectionState();
}

class _SummarySectionState extends State<SummarySection> {
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
                'Resumos:',
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CardSummary(
                titulo: 'Hoje',
                despesas: mediator
                    .calculaCustoHoje(), //valores devem ser variaveis de acordo com o banco
                recebimentos: mediator
                    .calculaRecebimentosHoje(), //valores devem ser variaveis de acordo com o banco
              ),
              const SizedBox(
                width: 10,
              ),
              CardSummary(
                titulo: 'Esta Semana',
                despesas: mediator
                    .calculaCustoDestaSemana(), //valores devem ser variaveis de acordo com o banco
                recebimentos: mediator
                    .calculaRecebimentosDestaSemana(), //valores devem ser variaveis de acordo com o banco
              ),
              const SizedBox(
                width: 10,
              ),
              CardSummary(
                titulo: 'Este Mês',
                despesas: mediator
                    .calculaCustoDesteMes(), //valores devem ser variaveis de acordo com o banco
                recebimentos: mediator
                    .calculaRecebimentosDesteMes(), //valores devem ser variaveis de acordo com o banco
              ),
            ],
          ),
        ),
      ],
    );
  }
}

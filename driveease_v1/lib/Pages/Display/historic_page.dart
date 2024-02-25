import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Pages/Pillar/edit_corrida_page.dart';
import 'package:driveease_v1/Pages/Pillar/edit_servico_page.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Cards/card_corrida.dart';
import 'package:driveease_v1/Widgets/Cards/card_servico.dart';
import 'package:flutter/material.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  late CorridaDaoDb _corridaDaoDb;
  late ServicoDaoDb _servicoDaoDb;
  Mediator mediator = Mediator();
  late int qtdServicoLista;

  _carregaListas() async {
    mediator.listaDeCorridas = await _corridaDaoDb.listar();
    mediator.listaDeServicos = await _servicoDaoDb.listar();
    qtdServicoLista = mediator.listaDeServicos.length;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _corridaDaoDb = CorridaDaoDb();
    _servicoDaoDb = ServicoDaoDb();
    _carregaListas();
  }

  _clickEditCorrida(Corrida corrida) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => EditCorridaPage(corrida: corrida),
      ),
    )
        .then((value) {
      setState(() {
        _carregaListas();
      });
    });
  }

  _removerCorrida(Corrida corrida) {
    _corridaDaoDb.excluir(corrida).then(
      (value) {
        _carregaListas();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Corrida removida!'),
            backgroundColor: Colors.grey,
            duration: Duration(seconds: 3),
          ),
        );
      },
    );
  }

  _clickRemoverCorrida(Corrida corrida) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Corrida'),
        content: const Text('Tem certeza que deseja remover esta Corrida?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: UtilsColors.corFloatingActionButton),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: UtilsColors.corFloatingActionButton),
                onPressed: () {
                  Navigator.of(context).pop();
                  _removerCorrida(corrida);
                },
                child: const Text(
                  'Remover',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _clickEditServico(Servico servico) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => EditServicoPage(servico: servico),
      ),
    )
        .then((value) {
      setState(() {
        _carregaListas();
      });
    });
  }

  _removerServico(Servico servico) {
    _servicoDaoDb.excluir(servico);
    _carregaListas();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Serviço removido!'),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 3),
      ),
    );
  }

  _clickRemoverServico(Servico servico) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Serviço'),
        content: const Text('Tem certeza que deseja remover este Serviço?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: UtilsColors.corFloatingActionButton),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: UtilsColors.corFloatingActionButton),
                onPressed: () {
                  Navigator.of(context).pop();
                  _removerServico(servico);
                },
                child: const Text(
                  'Remover',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: UtilsColors.corFundoTela,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Histórico'),
            backgroundColor: UtilsColors.corAppBar,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                color: UtilsColors.corTabBar,
                child: TabBar(
                  onTap: (value) {
                    setState(() {
                      _carregaListas();
                    });
                  },
                  indicatorColor: UtilsColors.corDestaqueOn,
                  labelColor: UtilsColors.corDestaqueOn,
                  unselectedLabelColor: UtilsColors.corNaoSelecionado,
                  tabs: const <Widget>[
                    Tab(
                      child: Text('Corridas'),
                    ),
                    Tab(
                      child: Text('Serviços'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10.0),
                  itemCount: mediator.listaDeCorridas.length,
                  itemBuilder: (context, index) {
                    Corrida corrida = mediator.listaDeCorridas[index];
                    return CardCorrida(
                      corrida: corrida,
                      onMenuClick: (MyItemCorrida item) {
                        switch (item) {
                          case MyItemCorrida.itemTap:
                          case MyItemCorrida.itemEdit:
                            _clickEditCorrida(corrida);
                            break;
                          case MyItemCorrida.itemLongPress:
                          case MyItemCorrida.itemDelete:
                            _clickRemoverCorrida(corrida);
                            break;
                        }
                      },
                    );
                  },
                ),
              ),
              Center(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10.0),
                  itemCount: mediator.listaDeServicos.length,
                  itemBuilder: (context, index) {
                    Servico servico = mediator.listaDeServicos[index];
                    return CardServico(
                      servico: servico,
                      onMenuClick: (MyItemServico item) {
                        switch (item) {
                          case MyItemServico.itemTap:
                          case MyItemServico.itemEdit:
                            _clickEditServico(servico);
                            break;
                          case MyItemServico.itemLongPress:
                          case MyItemServico.itemDelete:
                            _clickRemoverServico(servico);
                            break;
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

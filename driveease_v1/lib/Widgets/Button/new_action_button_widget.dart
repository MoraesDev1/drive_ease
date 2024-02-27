import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Button/new_meta_button_widget.dart';
import 'package:driveease_v1/Widgets/Button/new_servico_button_widget.dart';
import 'package:driveease_v1/Widgets/Button/star_stop_button_widget.dart';
import 'package:flutter/material.dart';

class MenuNovaAcao extends StatefulWidget {
  const MenuNovaAcao({super.key, required this.atualizaHome});

  final Function atualizaHome;

  @override
  State<MenuNovaAcao> createState() => _MenuNovaAcaoState();
}

class _MenuNovaAcaoState extends State<MenuNovaAcao> {
  double heightMenuButton = 50;
  double widthtMenuButton = 200;
  bool open = false;
  bool visible = false;

  _alteraVisible() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: open ? 170 : 20,
          right: 15,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: open ? 1 : 0,
            onEnd: () => _alteraVisible(),
            child: Visibility(
              visible: visible ? visible : open,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        NewServicoButton(atualizaHome: widget.atualizaHome),
                  );
                  setState(() {
                    open = !open;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: UtilsColors.corFloatingActionButton,
                  fixedSize: Size(widthtMenuButton, heightMenuButton),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Novo Serviço'),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: open ? 100 : 20,
          right: 15,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: open ? 1 : 0,
            child: Visibility(
              visible: visible ? visible : open,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NewMetaButton(),
                  );
                  setState(() {
                    open = !open;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: UtilsColors.corFloatingActionButton,
                  fixedSize: Size(widthtMenuButton, heightMenuButton),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Nova Meta'),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 15,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                open = !open;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: UtilsColors.corFloatingActionButton,
              fixedSize: Size(heightMenuButton, heightMenuButton),
              shape: const CircleBorder(),
            ),
            child: Text(!open ? '+' : 'x'),
          ),
        ),
        Positioned(
          bottom: -5,
          right: 125,
          child: StartStopButton(atualizaHome: widget.atualizaHome),
        ),
      ],
    );
  }
}

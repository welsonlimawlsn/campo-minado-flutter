import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final void Function(Campo) onAbre;
  final void Function(Campo) onAlternaMarcacao;

  TabuleiroWidget({
    @required this.tabuleiro,
    @required this.onAbre,
    @required this.onAlternaMarcacao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: tabuleiro.colunas,
        children: tabuleiro.campos
            .map((campo) => CampoWidget(
                  campo: campo,
                  onAlternaMarcacao: onAlternaMarcacao,
                  onAbre: onAbre,
                ))
            .toList(),
      ),
    );
  }
}

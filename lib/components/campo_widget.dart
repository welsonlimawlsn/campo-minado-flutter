import 'package:campo_minado/models/campo.dart';
import 'package:flutter/material.dart';

class CampoWidget extends StatelessWidget {
  final Campo campo;
  final void Function(Campo) onAbre;
  final void Function(Campo) onAlternaMarcacao;

  CampoWidget({
    @required this.campo,
    @required this.onAbre,
    @required this.onAlternaMarcacao,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAbre(campo),
      onLongPress: () => onAlternaMarcacao(campo),
      child: _getImage(),
    );
  }

  Widget _getImage() {
    var quantidadeMinas = campo.quantidadeMinasNaVizinhanca;
    if (campo.aberto && campo.minado && campo.explodido) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (campo.aberto && campo.minado) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (campo.aberto && quantidadeMinas >= 0) {
      return Image.asset('assets/images/aberto_$quantidadeMinas.jpeg');
    } else if (campo.marcado) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }
}

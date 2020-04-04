import 'dart:math';

import 'package:campo_minado/models/campo.dart';
import 'package:flutter/foundation.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int quantidadeBombas;
  final List<Campo> _campos = [];

  Tabuleiro({
    @required this.linhas,
    @required this.colunas,
    @required this.quantidadeBombas,
  }) {
    _criaCampos();
    _relacionaVizinhos();
    _sorteiaMinas();
  }

  void reinicia() {
    _campos.forEach((campo) => campo.reinicia());
    _sorteiaMinas();
  }

  void revelaMinas() => _campos.forEach((campo) => campo.revelaBomba());

  void _criaCampos() {
    for (int l = 0; l < linhas; l++) {
      for (int c = 0; c < colunas; c++) {
        _campos.add(Campo(
          coluna: c,
          linha: l,
        ));
      }
    }
  }

  void _relacionaVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionaVizinho(vizinho);
      }
    }
  }

  void _sorteiaMinas() {
    if (quantidadeBombas > linhas * colunas) {
      return;
    }
    int sorteadas = 0;

    while (sorteadas < quantidadeBombas) {
      var i = Random().nextInt(_campos.length);
      if (!_campos[i].minado) {
        _campos[i].mina();
        sorteadas++;
      }
    }
  }

  List<Campo> get campos => _campos;

  bool get resolvido => _campos.every((campo) => campo.resolvido);
}

import 'package:campo_minado/models/explosao_exception.dart';
import 'package:flutter/foundation.dart';

class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Campo({
    @required this.linha,
    @required this.coluna,
  });

  void adicionaVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }

    if (deltaColuna <= 1 && deltaLinha <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abre() {
    if (!_aberto) {
      _aberto = true;

      if (_minado) {
        _explodido = true;
        throw ExplosaoException();
      }

      if (vizinhacaSegura) {
        vizinhos.forEach((vizinho) => vizinho.abre());
      }
    }
  }

  void revelaBomba() {
    if (_minado) {
      _aberto = true;
    }
  }

  void mina() {
    _minado = true;
  }

  void alternaMarcacao() {
    _marcado = !_marcado;
  }

  void reinicia() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get vizinhacaSegura {
    return vizinhos.every((vizinho) => !vizinho._minado);
  }

  bool get resolvido {
    bool minadoEMarcado = _minado && _marcado;
    bool seguroEAberto = !_minado && _aberto;
    return minadoEMarcado || seguroEAberto;
  }

  int get quantidadeMinasNaVizinhanca {
    return vizinhos.where((vizinho) => vizinho._minado).length;
  }

  bool get explodido => _explodido;

  bool get minado => _minado;

  bool get marcado => _marcado;

  bool get aberto => _aberto;
}

import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class CampoMinadoScreen extends StatefulWidget {
  @override
  _CampoMinadoScreenState createState() => _CampoMinadoScreenState();
}

class _CampoMinadoScreenState extends State<CampoMinadoScreen> {
  bool _venceu;
  Tabuleiro _tabuleiro;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reinicia,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) => TabuleiroWidget(
              onAbre: _onAbre,
              onAlternaMarcacao: _onAlternaMarcacao,
              tabuleiro:
                  getTabuleiro(constraints.maxWidth, constraints.maxHeight),
            ),
          ),
        ),
      ),
    );
  }

  Tabuleiro getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int colunas = 15;
      double tamanhoCampo = largura / colunas;
      int linhas = (altura / tamanhoCampo).floor();
      _tabuleiro =
          Tabuleiro(colunas: colunas, linhas: linhas, quantidadeBombas: 100);
    }

    return _tabuleiro;
  }

  _reinicia() {
    setState(() {
      _tabuleiro.reinicia();
      _venceu = null;
    });
  }

  void _onAbre(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      try {
        campo.abre();
        if (_tabuleiro.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro.revelaMinas();
      }
    });
  }

  void _onAlternaMarcacao(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      campo.alternaMarcacao();
      if (_tabuleiro.resolvido) {
        _venceu = true;
      }
    });
  }
}

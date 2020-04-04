import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool venceu;
  final Function onReiniciar;

  ResultadoWidget({
    @required this.venceu,
    @required this.onReiniciar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getCor(),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                _getIcone(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onReiniciar,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(120);

  Color _getCor() {
    if (venceu == null) {
      return Colors.yellow;
    }
    return venceu ? Colors.green : Colors.red;
  }

  IconData _getIcone() {
    if (venceu == null) {
      return Icons.sentiment_satisfied;
    }
    return venceu
        ? Icons.sentiment_very_satisfied
        : Icons.sentiment_very_dissatisfied;
  }
}

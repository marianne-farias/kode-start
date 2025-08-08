import 'package:flutter/material.dart';

// Widget visual para exibir o status de um personagem (Alive, Dead, Unknown)
// Mostra uma bolinha colorida e o texto do status ao lado
class StatusIndicator extends StatelessWidget {
  final String status; 

  /// Cria um indicador visual de status.
  const StatusIndicator({super.key, required this.status});

  /// Retorna a cor correspondente ao status
  Color _getColor() {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: _getColor(),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          status,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

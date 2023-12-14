import 'package:flutter/material.dart';

class LeaveRow extends StatelessWidget {
  final int id;
  final String name;
  final int allocated;
  final int used;

  const LeaveRow(this.id, this.name, this.used, this.allocated, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
      child: Container(
        color: Colors.white12,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              name,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  used.toString(),
                  style: const TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Visibility(
                  visible: (allocated == 0) ? false : true,
                  child: const Text(
                    '/',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Visibility(
                  visible: (allocated == 0) ? false : true,
                  child: Text(
                    allocated.toString(),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

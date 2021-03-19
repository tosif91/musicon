import 'package:flutter/material.dart';

class ApiErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Row(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
              size: 45,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                'Please Try Again[server_error api limit]',
                // maxLines: 2,
                style: TextStyle(fontSize: 25, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

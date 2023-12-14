import 'package:flutter/cupertino.dart';

class MeetingParticipator extends StatelessWidget {
  final String image;

  const MeetingParticipator(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          image,
          width: 25,
          height: 20,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/dummy_avatar.png',
              width: 25,
              height: 20,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}

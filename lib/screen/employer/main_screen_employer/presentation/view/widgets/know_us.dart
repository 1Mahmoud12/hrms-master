import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/main_screen_employer/presentation/view/widgets/mission_flip.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class KnowUs extends StatelessWidget {
  const KnowUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Know Us'.tr,
          style: Styles.styleHeader,
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MissionFlip(
              backImage: 'assets/images/about.jpg',
              misIcon: Icons.assistant_photo,
              misHeading: 'Our Mission',
              misPara: 'Creating Integrated, Rich living Experience',
              misBackPara:
                  '''Our mission is to deliver an integrated, rich living experience by applying innovative local and global standards in real estate development. We aim to add the highest investment value through the construction of luxurious destinations and exceptional experiences.''',
            ),
            MissionFlip(
              backImage: 'assets/images/mission-1.jpg',
              misIcon: Icons.architecture_outlined,
              misHeading: 'Our Vision',
              misPara: 'Building a Better Future of Saudi Arabia',
              misBackPara:
                  """At Dar Bayat Development, we aspire to lead the way in real estate development in Saudi Arabia. Our vision is to contribute to the country's future strategic objectives by providing exceptional living experiences, high-quality products and services, and the highest levels of customer service and investment returns for our clients.""",
            ),
            MissionFlip(
              backImage: 'assets/images/partnership.jpg',
              misIcon: Icons.admin_panel_settings,
              misHeading: 'Our Values',
              misPara: 'The Heart and Soul of Dar Bayat Development',
              misBackPara:
                  '''At Dar Bayat Development, our values guide everything we do. We are committed to maintaining credibility, integration, quality, leadership, innovation, and change in all our projects and dealings with clients and partners.''',
            ),
          ],
        ),
      ),
    );
  }
}

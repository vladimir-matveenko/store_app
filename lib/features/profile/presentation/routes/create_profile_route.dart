import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../pages/create_profile_page.dart';

class CreateProfileRoute extends StatelessWidget {
  const CreateProfileRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateProfilePage(
      screenName: 'createProfileScreen.screenName'.tr(),
      successMessage: 'createProfileScreen.createSuccessMessage'.tr(),
      btnCreateText: 'createProfileScreen.btnCreate'.tr(),
    );
  }
}

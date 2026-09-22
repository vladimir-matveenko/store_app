import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../profile/presentation/pages/create_profile_page.dart';

class CreateUserRoute extends StatelessWidget {
  const CreateUserRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateProfilePage(
      screenName: 'createUserScreen.screenName'.tr(),
      successText: 'createUserScreen.created'.tr(),
      btnCreateText: 'createUserScreen.btnCreate'.tr(),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:store_app/app/constants/app_enums.dart';

import '../../../../core/presentation/widgets/custom_dropdown_menu.dart';
import '../../utils.dart';

class RoleSelector extends StatefulWidget {
  const RoleSelector({super.key, required this.onChanged});

  final Function(UserRole) onChanged;

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  late UserRole dropdownValue;
  late UserRole initialValue;
  late TextTheme textTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initialValue = UserRole.customer;
    dropdownValue = initialValue;
    textTheme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu<UserRole>(
      key: ValueKey(context.locale),
      initialValue: initialValue,
      leadingIcon: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: ProfileUtils.getRoleIcon(dropdownValue),
      ),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            dropdownValue = value;
            widget.onChanged(value);
          });
        }
      },
      entries: <DropdownMenuEntry<UserRole>>[
        DropdownMenuEntry<UserRole>(
          value: UserRole.customer,
          label: 'createProfileScreen.userRoles.customer'.tr(),
          leadingIcon: ProfileUtils.getRoleIcon(UserRole.customer),
          labelWidget: Text(
            'createProfileScreen.userRoles.customer'.tr(),
            style: textTheme.bodyMedium,
          ),
        ),
        DropdownMenuEntry<UserRole>(
          value: UserRole.admin,
          label: 'createProfileScreen.userRoles.admin'.tr(),
          leadingIcon: ProfileUtils.getRoleIcon(UserRole.admin),
          labelWidget: Text(
            'createProfileScreen.userRoles.admin'.tr(),
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

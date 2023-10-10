import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';
import 'package:video_to_audio/core/presentation/widgets/custom_app_bar.dart';
import 'package:video_to_audio/core/presentation/widgets/custom_error_message.dart';
import 'package:video_to_audio/core/presentation/widgets/custom_scaffold.dart';
import 'package:video_to_audio/core/presentation/widgets/loading_popup.dart';
import 'package:video_to_audio/core/presentation/widgets/spacers/horizontal_spacers.dart';
import 'package:video_to_audio/modules/settings/presentation/bloc/setting_bloc.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  static void navigateTo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Setting(),
      ),
    );
  }

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String _directory = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    context.read<SettingBloc>().add(OnGetDirectory());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is LoadingStart) {
          AlertLoading.show(context);
          setState(() {
            _errorMessage = '';
          });
        }

        if (state is LoadingStop) {
          AlertLoading.hide(context);
        }

        if (state is HasDirectoryData) {
          setState(() {
            _directory = state.directory;
          });
        }

        if (state is DirectoryError) {
          setState(() {
            _errorMessage = state.error.toString();
          });
        }
      },
      child: CustomScaffold(
        leadingIcon: LeadingIconType.sub,
        body: SingleChildScrollView(
          child: Padding(
            padding: UIConst.paddingScreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: UIConst.textLight,
                      ),
                ),
                const HorizontalSpacer32(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Save to Directory: ",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: UIConst.textLight,
                        ),
                  ),
                ),
                const HorizontalSpacer16(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: UIConst.borderRadiusWidget,
                          border: Border.all(color: UIConst.textLight),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  _directory,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: UIConst.textLight,
                                      ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  _chooseDirectory();
                                },
                                icon: Icon(
                                  Icons.folder,
                                  color: UIConst.textLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CustomErrorMessage(
                  message: _errorMessage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _chooseDirectory() async {
    context.read<SettingBloc>().add(OnChooseDirectory());
  }
}

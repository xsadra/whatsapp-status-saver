import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/logs/logger.dart' show logs;
import 'injection_container.dart' as injection;
import 'status_saver/data/models/models.dart';
import 'status_saver/presentation/bloc/medias/bloc.dart'
    show GetAccountMedias, MediasBloc;
import 'status_saver/presentation/bloc/saved_medias/bloc.dart'
    show GetSavedMedias, SavedMediasBloc;
import 'status_saver/presentation/pages/pages.dart'
    show AskPermissionScreen, HomeScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  logs.v('Run App');

  if (!await Permission.storage.isGranted) {
    logs.i('Ask for storage permission!');
    bool isGranted = await Permission.storage.request().isGranted;
    logs.i('Is storage permission isGranted: $isGranted');
  }

  runApp(MainApp(hasPermission: await Permission.storage.isGranted));
}

class MainApp extends StatelessWidget {
  final bool hasPermission;

  const MainApp({
    Key? key,
    required this.hasPermission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logs.v('build MainApp');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Status Saver',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => injection.sl<MediasBloc>()
                ..add(
                    GetAccountMedias(setAccountToShow: AccountType.WhatsApp))),
          BlocProvider(
              create: (context) =>
                  injection.sl<SavedMediasBloc>()..add(GetSavedMedias())),
        ],
        child: hasPermission ? HomeScreen() : AskPermissionScreen(),
      ),
    );
  }
}

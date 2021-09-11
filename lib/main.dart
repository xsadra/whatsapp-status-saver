import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_status_saver/core/logs/logger.dart';

import 'injection_container.dart' as injection.dart';
import 'status_saver/data/models/models.dart';
import 'status_saver/presentation/bloc/medias/bloc.dart';
import 'status_saver/presentation/bloc/saved_medias/bloc.dart';
import 'status_saver/presentation/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
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
        child: HomeScreen(),
      ),
    );
  }
}

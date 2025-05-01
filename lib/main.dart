import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/data/repositories/login_repository_impl.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:halal_media/data/sources/login_remote_sources_impl.dart';
import 'package:halal_media/presentation/cubit/home/home_cubit.dart';
import 'package:halal_media/presentation/cubit/login/login_cubit.dart';
import 'package:halal_media/presentation/screen/auth_screen/login_screen.dart';
import 'package:halal_media/presentation/screen/navigation_bar.dart';

import 'package:flutter_quill/flutter_quill.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final loginRemoteSource = LoginRemoteSourcesImpl(dio);
    final loginRepository = LoginRepositoryImpl(loginRemoteSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => LoginCubit(loginRepository)),
        BlocProvider<HomeCubit>(
          create: (_) {
            final cubit = HomeCubit(VideoRepo());
            cubit.videoLoad();
            return cubit;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Halal Media',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.lightGreen),
        ),
        home: const Navbar(),
        localizationsDelegates: [FlutterQuillLocalizations.delegate],
      ),
    );
  }
}

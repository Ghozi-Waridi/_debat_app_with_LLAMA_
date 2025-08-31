import 'package:debate_app/features/Debate/presentation/bloc/debate_bloc.dart';
import 'package:debate_app/features/Topics/presentation/bloc/topics_bloc.dart';
import 'package:debate_app/features/Topics/presentation/pages/topic_page.dart';
import 'package:debate_app/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<DebateBloc>()),
        BlocProvider(
          create: (context) => di.sl<TopicsBloc>()..add(GetTopicsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Debat LLM',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TopicPage(),
      ),
    );
  }
}

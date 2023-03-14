import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/example_event.dart';
import 'bloc/example_bloc.dart';
import 'bloc/example_state.dart';
import 'repository/example_repository.dart';

class Example2Page extends StatelessWidget {
  const Example2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ExampleRepository(),
      child: BlocProvider(
        // create: (_) {
        //   ExampleBloc exampleBloc = ExampleBloc(
        //       exampleRepository: RepositoryProvider.of<ExampleRepository>(_));
        //   exampleBloc.add(ExampleEventFindNames());
        //   return exampleBloc;
        // },
        create: (_) => ExampleBloc(
          exampleRepository: RepositoryProvider.of<ExampleRepository>(_),
        )..add(ExampleEventFindNames()),
        child: const ExampleView(),
      ),
    );
  }
}

class ExampleView extends StatelessWidget {
  const ExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example2Page'),
      ),
      body: BlocListener<ExampleBloc, ExampleState>(
        listener: (context, state) {
          if (state.status == ExampleStateStatus.data) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Lista com ${state.names.length} valores'),
              ),
            );
          }
        },
        child: Column(
          children: [
            BlocBuilder<ExampleBloc, ExampleState>(
              builder: (context, state) {
                if (state.status == ExampleStateStatus.initial) {
                  return const CircularProgressIndicator();
                }
                if (state.status == ExampleStateStatus.data) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.names.length,
                    itemBuilder: (context, index) {
                      final name = state.names[index];
                      return ListTile(
                        title: Text(name),
                        onTap: () {
                          context
                              .read<ExampleBloc>()
                              .add(ExampleEventRemoveName(name));
                        },
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

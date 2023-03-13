import 'package:contacts_bloc_adf/example/bloc/example_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/example_bloc.dart';
import 'bloc/example_state.dart';
import 'repository/example_repository.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

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
        title: const Text('ExamplePage'),
      ),
      body: BlocListener<ExampleBloc, ExampleState>(
        listener: (context, state) {
          if (state is ExampleStateData) {
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
                if (state is ExampleStateInitial) {
                  return const CircularProgressIndicator();
                }
                if (state is ExampleStateData) {
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

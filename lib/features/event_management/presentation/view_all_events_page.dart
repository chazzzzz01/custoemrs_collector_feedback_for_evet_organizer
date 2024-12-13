import 'package:customers_collector_feedback/core/services/injection_container.dart';
import 'package:customers_collector_feedback/core/widgets/empty_state_list.dart';
import 'package:customers_collector_feedback/core/widgets/loading_state_shimmer_list.dart';
import 'package:customers_collector_feedback/features/event_management/presentation/add_edit_event_page.dart';
import 'package:customers_collector_feedback/features/event_management/presentation/cubit/event_cubit.dart';
import 'package:customers_collector_feedback/features/event_management/presentation/cubit/event_state.dart';
import 'package:customers_collector_feedback/features/event_management/presentation/view_event_page.dart';
import 'package:customers_collector_feedback/features/feedback_management/presentation/cubit/feedback_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/error_state_list.dart';

class ViewAllEventsPage extends StatefulWidget {
  const ViewAllEventsPage({super.key});

  @override
  State<ViewAllEventsPage> createState() => _ViewAllEventsPageState();
}

class _ViewAllEventsPageState extends State<ViewAllEventsPage> {
  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
      ),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const LoadingStateShimmerList();
          } else if (state is EventLoaded) {
            if (state.events.isEmpty) {
              return const EmptyStateList(
                  imageAssetName: 'assets/images/empty.png',
                  title: 'Oops... There are no events found.',
                  description: "Tap '+' to add a new event.");
            }
            return ListView.builder(

              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final currentEvent = state.events[index];


                return Card(
                  child: ListTile(
                    title: Text("Event ${currentEvent.description}"),
                    subtitle: Text(currentEvent.title),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => serviceLocator<EventCubit>(),
                            child: ViewEventPage(event: currentEvent),
                          ),
                        ),
                      );
                      context
                          .read<EventCubit>()
                          .getAllEvents(); // Refresh the page

                      if (result.runtimeType == String) {
                        final snackBar = SnackBar(content: Text(result));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                );
              },
            );
          } else if (state is EventError) {
            return ErrorStateList(
              imageAssetName: 'assets/images/error.png',
              errorMessage: state.message,
              onRetry: () {
                context.read<EventCubit>().getAllEvents();
              },
            );
          } else {
            return const EmptyStateList(
                imageAssetName: 'assets/images/empty.png',
                title: 'Oops... There are no events found.',
                description: "Tap '+' to add a new event.");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to CreateEventPage with both EventCubit and GuestCubit
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => serviceLocator<EventCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => serviceLocator<FeedbackFormCubit>(),
                  ),
                ],
                child: const AddEditEventPage(),
              ),
            ),
          );

          // Refresh the event list
          context.read<EventCubit>().getAllEvents();

          // Show SnackBar with result if it's a string
          if (result.runtimeType == String) {
            final snackBar = SnackBar(content: Text(result));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

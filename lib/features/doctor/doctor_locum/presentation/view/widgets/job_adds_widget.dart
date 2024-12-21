import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/features/doctor/doctor_locum/domain/models/job_add_model.dart';
import 'package:locum_app/features/doctor/doctor_locum/presentation/cubits/show_all_add/show_all_adds_cubit.dart';
import 'package:locum_app/features/doctor/doctor_locum/presentation/view/widgets/job_add_widget.dart';

class JobAddsWidget extends StatefulWidget {
  const JobAddsWidget({super.key});

  @override
  State<JobAddsWidget> createState() => _JobAddsWidgetState();
}

class _JobAddsWidgetState extends State<JobAddsWidget> {
  late final ShowAllAddsCubit controller;

  @override
  void initState() {
    controller = context.read<ShowAllAddsCubit>();
    controller.showAllJobAdds(limit: 5, page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowAllAddsCubit, ShowAllAddsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.jobAddsResponse?.data?.length ?? 0,
          itemBuilder: (context, index) {
            final JobAddModel? model = state.jobAddsResponse?.data?[index];
            if (model == null) return const SizedBox();
            return JobAdWidget(jobAddModel: model);
          },
        );
      },
    );
  }
}

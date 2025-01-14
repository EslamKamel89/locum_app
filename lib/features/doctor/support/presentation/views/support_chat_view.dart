import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/widgets/default_drawer.dart';
import 'package:locum_app/core/widgets/main_scaffold.dart';
import 'package:locum_app/core/widgets/no_data_widget.dart';
import 'package:locum_app/features/doctor/support/presentation/cubits/get_all_messages/get_all_messages_cubit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SupportChatView extends StatefulWidget {
  const SupportChatView({super.key});

  @override
  State<SupportChatView> createState() => _SupportChatViewState();
}

class _SupportChatViewState extends State<SupportChatView> {
  late final GetAllMessagesCubit controller;

  @override
  void initState() {
    _initState();
    super.initState();
  }

  Future _initState() async {
    controller = context.read<GetAllMessagesCubit>();
    await controller.fetchAllSupport();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllMessagesCubit, GetAllMessagesState>(
      builder: (context, state) {
        return MainScaffold(
          appBarTitle: "Support Chat",
          drawer: const DefaultDoctorDrawer(),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   child: Icon(MdiIcons.refresh  ),
          // ),
          child: Column(
            children: [
              Expanded(
                child: state.supportModels?.isEmpty == true && state.responseType != ResponseEnum.loading
                    ? const NoDataWidget()
                    : state.supportModels?.isEmpty == true && state.responseType == ResponseEnum.loading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: state.supportModels!.length,
                            reverse: true,
                            padding: const EdgeInsets.all(16.0),
                            itemBuilder: (context, index) {
                              final message = state.supportModels![state.supportModels!.length - 1 - index];
                              // final message = state.supportModels![index];
                              final isUser = message.sender == "user";

                              return Align(
                                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                                child: Animate(
                                  effects: [
                                    SlideEffect(duration: 300.ms, begin: const Offset(1, 0)),
                                    FadeEffect(duration: 300.ms),
                                  ],
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                                    decoration: BoxDecoration(
                                      color: isUser ? context.primaryColor : Colors.grey[300],
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(12.0),
                                        topRight: const Radius.circular(12.0),
                                        bottomLeft: isUser ? const Radius.circular(12.0) : Radius.zero,
                                        bottomRight: isUser ? Radius.zero : const Radius.circular(12.0),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message.content ?? '',
                                          style: TextStyle(
                                            color: isUser ? Colors.white : Colors.black,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          message.createdAt ?? '',
                                          style: TextStyle(
                                            color: isUser ? Colors.white70 : Colors.black54,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
              _buildMessageInput(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: const BoxDecoration(
          // color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: context.secondaryHeaderColor,
          //     blurRadius: 4.0,
          //     offset: const Offset(0, -2),
          //   ),
          // ],
          ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type a message",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send, color: context.secondaryHeaderColor),
          ),
          controller.state.responseType == ResponseEnum.loading
              ? Container(width: 20, height: 20, alignment: Alignment.center, child: const CircularProgressIndicator())
              : InkWell(
                  onTap: () {
                    controller.fetchAllSupport();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Icon(MdiIcons.refresh, color: Colors.white),
                  ),
                )
        ],
      ),
    );
  }
}

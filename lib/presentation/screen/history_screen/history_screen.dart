import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:halal_media/presentation/cubit/history/history_cubit.dart';
import 'package:halal_media/presentation/cubit/video_play/video_play_cubit.dart';
import 'package:halal_media/presentation/screen/video_play/video_play_screen.dart';
import 'package:halal_media/presentation/widgets/medium_thumbnail._card.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';
import 'package:intl/intl.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/presentation/widgets/button/custom_dropdown.dart';
import 'package:halal_media/presentation/widgets/custom_appbar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String selectedValue = "Today";
  DateTime? selectedDate = DateTime.now();

  final List<String> sortOptions = [
    'Today',
    'Yesterday',
    'This Week',
    'This Month',
    'Last Month',
    'Custom',
  ];

  Future<DateTime?> _pickDate() async {
    final historyState = context.read<HistoryCubit>().state;

    DateTime initial = DateTime.now();
    if (historyState is HistoryLoaded && historyState.selectedDate != null) {
      initial = historyState.selectedDate!;
    }

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.green,
              onPrimary: Colors.white,
              onSurface: AppColor.deepGreen,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColor.black900),
            ),
          ),
          child: child!,
        );
      },
    );

    return picked;
  }

  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().fetchHistory('This Month');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scafoldBackground,
      appBar: CustomAppbar(
        bottomBorder: true,
        title: "History",
        isNavbar: false,
        appActionsBar: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/search_black.png',
              height: 20,
              width: 20,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Row(
                    children: [
                      CustomDropdown(
                        selectedValue:
                            sortOptions.contains(state.selectedFilter)
                                ? state.selectedFilter
                                : selectedValue,
                        items: sortOptions,
                        onChanged: (value) async {
                          if (value == 'Custom') {
                            final picked = await _pickDate();
                            if (picked != null) {
                              context.read<HistoryCubit>().fetchHistory(
                                "Custom",
                                date: picked,
                              );
                            }
                          } else if (value != null) {
                            context.read<HistoryCubit>().fetchHistory(value);
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed:
                            state.selectedFilter == "Custom"
                                ? () async {
                                  final picked = await _pickDate();
                                  if (picked != null) {
                                    context.read<HistoryCubit>().fetchHistory(
                                      "Custom",
                                      date: picked,
                                    );
                                  }
                                }
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: AppColor.gray200),
                          ),
                        ),
                        child: Text(
                          state.selectedDate == null
                              ? 'Pick Date'
                              : DateFormat(
                                'dd/MM/yyyy',
                              ).format(state.selectedDate!),
                          style: TextStyle(color: AppColor.white),
                        ),
                      ),
                    ],
                  ),
                ),

                state.isVideolistLoading
                    ? const Expanded(
                      child: Center(child: CustomProgressIndicator()),
                    )
                    : Expanded(
                      child: ListView.builder(
                        itemCount: state.videos.length,
                        itemBuilder: (context, index) {
                          final video = state.videos[index];
                          final isLastItem = index == state.videos.length;
                          final isFirstItem = index == 0;
                          return Column(
                            children: [
                              if (isFirstItem) AppDimension.h8,
                              MediumThumbnailCard(
                                channelName: video.channelName,
                                thumbnail: video.thumbnail,
                                avatar: video.avatar,
                                title: video.title,
                                views: video.views,
                                date: video.date,

                                onFavorite: () {},
                                onShare: () {},
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => BlocProvider(
                                            create:
                                                (context) =>
                                                    VideoPlayCubit(VideoRepo()),
                                            child: VideoPlayScreen(
                                              id: video.videoId,
                                            ),
                                          ),
                                    ),
                                  );
                                },
                              ),
                              if (!isLastItem) AppDimension.h16,
                            ],
                          );
                        },
                      ),
                    ),
              ],
            );
          } else if (state is HistoryError) {
            return const Center(child: Text("Something went wrong"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

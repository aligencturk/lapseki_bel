import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/ferry_schedule.dart';
import '../../../viewmodels/ferry_viewmodel.dart';
import '../../widgets/language_switcher.dart';

class FerryScreen extends StatefulWidget {
  const FerryScreen({super.key});

  @override
  State<FerryScreen> createState() => _FerryScreenState();
}

class _FerryScreenState extends State<FerryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FerryViewModel>().loadSchedules();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feribot Seferleri',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,

        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Lapseki → Gelibolu'),
            Tab(text: 'Gelibolu → Lapseki'),
          ],
        ),
      ),
      body: Consumer<FerryViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    viewModel.error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.error),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadSchedules(),
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildScheduleList(context, viewModel.toGeliboluSchedule),
              _buildScheduleList(context, viewModel.toLapsekiSchedule),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScheduleList(BuildContext context, FerrySchedule? schedule) {
    if (schedule == null) {
      return const Center(
        child: Text(
          'Sefer saati bulunamadı',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: schedule.times.length,
      itemBuilder: (context, index) {
        final time = schedule.times[index];
        final isHourPassed = _isTimePassed(time);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isHourPassed
                  ? AppColors.textSecondary.withValues(alpha: 0.3)
                  : AppColors.primaryBlue.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isHourPassed
                    ? AppColors.textSecondary.withValues(alpha: 0.1)
                    : AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.schedule,
                color: isHourPassed
                    ? AppColors.textSecondary
                    : AppColors.primaryBlue,
                size: 24,
              ),
            ),
            title: Text(
              time,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isHourPassed
                    ? AppColors.textSecondary
                    : AppColors.primaryBlue,
              ),
            ),
            trailing: isHourPassed
                ? const Text(
                    'Kalktı',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  )
                : const Icon(Icons.arrow_forward, color: AppColors.primaryBlue),
          ),
        );
      },
    );
  }

  bool _isTimePassed(String time) {
    try {
      final now = DateTime.now();
      final times = time.split(':');
      final hour = int.parse(times[0]);
      final minute = int.parse(times[1]);
      final eventTime = DateTime(now.year, now.month, now.day, hour, minute);

      return now.isAfter(eventTime);
    } catch (e) {
      return false;
    }
  }
}

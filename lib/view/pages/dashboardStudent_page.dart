import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/dashboardStudent_model.dart';
import '../../shared/theme.dart';
import '../../viewmodel/dashboardStudent_viewmodel.dart';

class DashboardStudentPage extends StatelessWidget {
  const DashboardStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardStudentViewModel>(
      builder: (context, viewModel, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: _buildAppBar(context, viewModel),
            body: TabBarView(
              children: [
                _buildRecommendationTab(viewModel, context),
                _buildApplicationTab(viewModel, context),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    DashboardStudentViewModel viewModel,
  ) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 60,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "assets/images/logo.png",
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: PopupMenuButton<int>(
            onSelected: (index) {
              viewModel.setIndex(index);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 0, child: Text("Jobs")),
              const PopupMenuItem(value: 1, child: Text("My CV")),
              const PopupMenuItem(value: 2, child: Text("Dashboard")),
              const PopupMenuItem(value: 3, child: Text("Settings")),
            ],
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.lightOrange,
              backgroundImage: const NetworkImage(
                "https://i.pravatar.cc/150?img=12",
              ),
            ),
          ),
        ),
      ],
      bottom: const TabBar(
        labelColor: AppColors.primaryOrange,
        unselectedLabelColor: AppColors.grey,
        indicatorColor: AppColors.primaryOrange,
        indicatorWeight: 3,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        tabs: [
          Tab(text: "Recommendation Inbox"),
          Tab(text: "Application Status"),
        ],
      ),
    );
  }

  // --- RECOMMENDATIONS ---
  Widget _buildRecommendationTab(
    DashboardStudentViewModel viewModel,
    BuildContext context,
  ) {
    if (viewModel.recommendations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.inbox_rounded, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text("Inbox is empty", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: viewModel.recommendations.length,
      itemBuilder: (context, index) {
        final item = viewModel.recommendations[index];
        return InboxRecommendationItem(
          item: item,
          onAccept: () => viewModel.acceptRecommendation(item.id, context),
        );
      },
    );
  }

  // --- CONTENT TAB 2: APPLICATION STATUS ---
  Widget _buildApplicationTab(
    DashboardStudentViewModel viewModel,
    BuildContext context,
  ) {
    if (viewModel.applications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.assignment_rounded, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No active applications",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Application History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: const Text("Filter"),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryOrange,
                  ),
                ),
              ],
            ),
          ),

          // TABLE CONTAINER
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
                    dataRowHeight: 90,
                    columnSpacing: 24,
                    horizontalMargin: 20,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Position & Company',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Status',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Notes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                    rows: viewModel.applications
                        .map((item) => _buildDataRow(item))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(ApplicationItem item) {
    Color statusColor;
    String statusText;
    String noteText;

    switch (item.status) {
      case ApplicationStatus.applied:
        statusColor = AppColors.blue;
        statusText = "Applied";
        noteText = "Your application is being reviewed.";
        break;
      case ApplicationStatus.shortlisted:
        statusColor = AppColors.primaryOrange;
        statusText = "Shortlisted";
        noteText = "Passed initial screening. Forwarded to HR.";
        break;
      case ApplicationStatus.accepted:
        statusColor = AppColors.green;
        statusText = "Accepted";
        noteText = "Congratulations! Check your email for the offer letter.";
        break;
      case ApplicationStatus.rejected:
        statusColor = AppColors.red;
        statusText = "Rejected";
        noteText = "Sorry, your qualifications did not match.";
        break;
    }

    return DataRow(
      cells: [
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.role,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.companyName,
                  style: const TextStyle(color: AppColors.grey, fontSize: 12),
                ),
                Text(
                  item.date,
                  style: TextStyle(
                    color: AppColors.grey.withOpacity(0.7),
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: statusColor.withOpacity(0.3)),
            ),
            child: Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 180,
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: statusColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    noteText,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Inbox Recommendation Item
class InboxRecommendationItem extends StatelessWidget {
  final RecommendationItem item;
  final VoidCallback onAccept;

  const InboxRecommendationItem({
    super.key,
    required this.item,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.business_rounded,
              color: AppColors.primaryOrange,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.role,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.companyName,
                  style: const TextStyle(color: AppColors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, size: 14, color: Colors.green),
                const SizedBox(width: 4),
                Text(
                  item.matchScore,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: item.isAccepted
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: AppColors.grey,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Accepted",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                : ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Accept Offer",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

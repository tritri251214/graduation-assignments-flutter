import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/models/ticket.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/widgets/empty.dart';
import 'package:graduation_assignments_flutter/widgets/list_tickets.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';

class ListPastTicketsTab extends StatefulWidget {
  const ListPastTicketsTab({
    super.key,
    required this.loading,
    required this.groupTickets,
    this.router = const AppRouter(),
  });

  final bool loading;
  final AppRouter router;
  final Map<String, List<Ticket>> groupTickets;

  @override
  State<StatefulWidget> createState() => _ListTicketsTabState();
}

class _ListTicketsTabState extends State<ListPastTicketsTab> {
  Widget buildNumberOfTicket(int numberOfTicket) {
    Widget buildContent;
    if (numberOfTicket == 1) {
      buildContent = Text('$numberOfTicket ticket');
    } else {
      buildContent = Text('$numberOfTicket ticket\'s');
    }
    return buildContent;
  }

  Widget buildGroupTicket(List<Ticket> groupTickets, String titleGroup) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleGroup,
            style: const TextStyle(
                fontFamily: AppStrings.rootFont,
                fontSize: 16,
                color: AppColors.placeholderText)),
        const SizedBox(height: 10),
        ListTicketsTab(loading: widget.loading, ticketData: groupTickets),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return const LoadingListEvent();
    } else if (widget.groupTickets.isEmpty) {
      return const EmptyWidget(title: 'No ticket yes', description: 'Make sure you have added ticket\'s in this section');
    } else {
      final children = <Widget>[];
      for (var group in widget.groupTickets.entries) {
        children.add(buildGroupTicket(group.value, group.key));
      }
      return Column(children: children);
    }
  }
}

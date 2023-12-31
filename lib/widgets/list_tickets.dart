import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/models/ticket.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/widgets/empty.dart';
import 'package:graduation_assignments_flutter/widgets/load_image.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';

class ListTicketsTab extends StatefulWidget {
  const ListTicketsTab({
    super.key,
    required this.loading,
    required this.ticketData,
    this.router = const AppRouter(),
  });

  final bool loading;
  final AppRouter router;
  final List<Ticket> ticketData;

  @override
  State<StatefulWidget> createState() => _ListTicketsTabState();
}

class _ListTicketsTabState extends State<ListTicketsTab> {
  Widget buildNumberOfTicket(int numberOfTicket) {
    Widget buildContent;
    if (numberOfTicket == 1) {
      buildContent = Text('$numberOfTicket ticket');
    } else {
      buildContent = Text('$numberOfTicket ticket\'s');
    }
    return buildContent;
  }

  Widget buildTicket(Ticket ticket, bool? isLatest) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderInput),
            borderRadius: AppDimensions.cardBorderRadius,
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Icon(CupertinoIcons.bookmark_fill,
                                color: AppColors.primaryColor, size: 40),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(ticket.title,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontFamily: AppStrings.rootFont,
                                        fontSize: 16)),
                                Text(ticket.getFormatTime()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      buildNumberOfTicket(ticket.numberOfTicket),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 150,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0)),
                    child: LoadImage(imageUrl: ticket.getImageUrl()),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return const LoadingListEvent();
    } else if (widget.ticketData.isEmpty) {
      return const EmptyWidget(title: 'No ticket yes', description: 'Make sure you have added ticket\'s in this section');
    } else {
      final children = <Widget>[];
      for (var i = 0; i < widget.ticketData.length; i++) {
        if (i == 0) {
          children.add(buildTicket(widget.ticketData[i], true));
        } else {
          children.add(buildTicket(widget.ticketData[i], false));
        }
      }
      return Column(children: children);
    }
  }
}

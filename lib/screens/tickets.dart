import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/models/ticket.dart';
import 'package:graduation_assignments_flutter/providers/providers.dart';
import 'package:graduation_assignments_flutter/widgets/bottom_navigation_bar.dart';
import 'package:graduation_assignments_flutter/widgets/empty.dart';
import 'package:graduation_assignments_flutter/widgets/list_past_tickets.dart';
import 'package:graduation_assignments_flutter/widgets/list_tickets.dart';
import 'package:provider/provider.dart';

class TicketScreen extends StatefulWidget {
  static String routeName = '/tickets';

  const TicketScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen>
    with TickerProviderStateMixin {
  List<Ticket> _ticketData = [];
  Map<String, List<Ticket>> _groupTickets = {};
  bool _isLoading = false;
  late TicketProvider _ticketProvider;
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _ticketProvider = context.read<TicketProvider>();
    _reload();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _ticketProvider.getListTicket();
      setState(() {
        _ticketData = _ticketProvider.ticketData;
        _groupTickets = _ticketProvider.groupTickets;
      });
    } catch (error) {
      // todo
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildEmpty() {
    return const EmptyWidget(
        title: 'No ticket yes',
        description: 'Make sure you have added ticket\'s in this section');
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/images/empty_data_icon.png'), context);

    Widget buildUpcommingTab;
    if (!_isLoading && _ticketData.isEmpty) {
      buildUpcommingTab = buildEmpty();
    } else {
      buildUpcommingTab = SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: ListTicketsTab(loading: _isLoading, ticketData: _ticketData),
      );
    }

    Widget buildPastTab;
    if (!_isLoading && _groupTickets.isEmpty) {
      buildPastTab = buildEmpty();
    } else {
      buildPastTab = SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: ListPastTicketsTab(
            loading: _isLoading, groupTickets: _groupTickets),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: const Text('Tickets',
            style: TextStyle(
                fontSize: 24,
                color: AppColors.white,
                fontWeight: FontWeight.bold)),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(bottom: 10),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: AppColors.white,
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.backgroundCard,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(
                  child: Text('Upcomming', style: TextStyle(fontSize: 16)),
                ),
                Tab(
                  child: Text('Past tickets', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          buildUpcommingTab,
          buildPastTab,
        ],
      ),
      bottomNavigationBar:
          const BottomNavigationBarWidget(selectedMenu: Menu.tickets),
    );
  }
}

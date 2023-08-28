import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_assignments_flutter/models/ticket.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';

class TicketProvider with ChangeNotifier {
  List<Ticket> ticketData = [];
  Map<String, List<Ticket>> groupTickets = {};

  Future<void> getListTicket() async {
    try {
      final List<dynamic> response = await get('tickets?_sort=time&_order=asc');
      if (response.isEmpty) {
        return;
      }
      final List<Ticket> loadedTicketData = [];
      for (var item in response) {
        loadedTicketData.add(
          Ticket.fromJson(item),
        );
      }
      var groupByYear = groupBy(loadedTicketData, (Ticket ticket) => ticket.getYear());

      ticketData = loadedTicketData;
      groupTickets = groupByYear;
      notifyListeners();
      return;
    } catch (error) {
      // ignore: avoid_print
      print('getListTicket: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';

class EventProvider with ChangeNotifier {
  List<Event> _eventData = [];
  List<Event> _favouriteEventData = [];
  Event? _latestEvent;

  List<Event> get eventData => _eventData;
  List<Event> get favouriteEventData => _favouriteEventData;
  Event? get latestEvent => _latestEvent;

  set eventData(List<Event> data) {
    _eventData = data;
    notifyListeners();
  }

  Future<void> getListEvent() async {
    try {
      final List<dynamic> response = await get('events?_sort=id&_order=desc');
      if (response.isEmpty) {
        return;
      }
      final List<Event> loadedEventData = [];
      for (var item in response) {
        loadedEventData.add(
          Event.fromJson(item),
        );
      }
      eventData = loadedEventData;
    } catch (error) {
      // ignore: avoid_print
      print('getListEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<void> getLatestEvent() async {
    try {
      final List<dynamic> response = await get('events?_sort=id&_order=desc');
      if (response.isEmpty) {
        return;
      }
      final List<Event> loadedEventData = [];
      for (var item in response) {
        loadedEventData.add(
          Event.fromJson(item),
        );
      }
      _latestEvent = loadedEventData[0];
      notifyListeners();
    } catch (error) {
      // ignore: avoid_print
      print('getLatestEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<Event> getEvent(int eventId) async {
    try {
      final response = await get('events/$eventId');
      return Event.fromJson(response);
    } catch (error) {
      // ignore: avoid_print
      print('getEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<List<Event>> searchEvents(
      String textSearch, String sortBy, String sortType) async {
    try {
      late List<dynamic> response;
      if (textSearch == '') {
        response = await get('events?_sort=$sortBy&_order=$sortType');
      } else {
        response = await get(
            'events?name_like=$textSearch&_sort=$sortBy&_order=$sortType');
      }
      if (response.isEmpty) {
        return [];
      }
      final List<Event> loadedEventData = [];
      for (var item in response) {
        loadedEventData.add(
          Event.fromJson(item),
        );
      }
      loadedEventData;
      return loadedEventData;
    } catch (error) {
      // ignore: avoid_print
      print('searchEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<Event> addEvent(Event data) async {
    try {
      final response = await post('events', data: data);
      refreshEvents();
      return Event.fromJson(response);
    } catch (error) {
      // ignore: avoid_print
      print('addEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<Event> updateEvent(Event data) async {
    try {
      final response = await put('events/${data.id}', data: data);

      return Event.fromJson(response);
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<bool> deleteEvent(int eventId, bool isLatestEvent) async {
    try {
      await delete('events/$eventId');
      _eventData.removeWhere((event) => event.id == eventId);
      if (isLatestEvent) {
        _latestEvent = _eventData[0];
      }
      notifyListeners();
      return true;
    } catch (error) {
      // ignore: avoid_print
      print('deleteEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<Event> favouriteEvent(int eventId) async {
    try {
      int index = _eventData.indexWhere((item) => item.id == eventId);
      Event event = _eventData[index];
      event.favourite = true;
      final response = await put('events/$eventId', data: event.toJson());
      Event newEvent = Event.fromJson(response);
      _eventData[index].favourite = newEvent.favourite;
      notifyListeners();
      return newEvent;
    } catch (error) {
      // ignore: avoid_print
      print('favoriteEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<Event> unFavouriteEvent(int eventId) async {
    try {
      int index = _eventData.indexWhere((item) => item.id == eventId);
      Event event = _eventData[index];
      event.favourite = false;
      final response = await put('events/$eventId', data: event.toJson());
      Event newEvent = Event.fromJson(response);
      _eventData[index].favourite = newEvent.favourite;
      notifyListeners();
      return newEvent;
    } catch (error) {
      // ignore: avoid_print
      print('unFavoriteEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Event getEventById(int eventId) {
    return _eventData.firstWhere((item) => item.id == eventId);
  }

  Future<void> refreshFavourites() {
    _favouriteEventData.clear();
    return getFavouritesEvent();
  }

  Future<void> refreshEvents() async {
    _eventData.clear();
    getListEvent();
    getLatestEvent();
  }

  Future<void> getFavouritesEvent() async {
    try {
      List<dynamic> response = await get('events?favourite=true');
      if (response.isEmpty) {
        return;
      }
      final List<Event> loadedEventData = [];
      for (var item in response) {
        loadedEventData.add(
          Event.fromJson(item),
        );
      }
      _favouriteEventData = loadedEventData;
      notifyListeners();
      return;
    } catch (error) {
      // ignore: avoid_print
      print('getFavoritesEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';

class EventProvider with ChangeNotifier {
  List<Event> eventData = [];
  Event? get latestEvent {
    if (eventData.isEmpty) {
      return null;
    }
    return eventData[0];
  }

  Future<void> getListEvent() async {
    try {
      final List<dynamic> response = await get('events');
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
      notifyListeners();
    } catch (error) {
      // ignore: avoid_print
      print('getListEvent: $error');
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

  Future<List<Event>> searchEvents(String textSearch, String sortBy, String sortType) async {
    try {
      late List<dynamic> response;
      if (textSearch == '') {
        response = await get('events?_sort=$sortBy&_order=$sortType');
      } else {
        response = await get('events?name_like=$textSearch&_sort=$sortBy&_order=$sortType');
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

      return Event.fromJson(json.decode(response.body));
      // getListEvent();
      // return event;
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

      return Event.fromJson(json.decode(response.body));
      // getListEvent();
      // return event;
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<bool> deleteEvent(int eventId) async {
    try {
      await delete('events/$eventId');
      eventData.removeWhere((event) => event.id == eventId);
      return true;
    } catch (error) {
      // ignore: avoid_print
      print('deleteEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<Event> favoriteEvent(int eventId) async {
    try {
      int index = eventData.indexWhere((item) => item.id == eventId);
      Event event = eventData[index];
      event.favorite = true;
      final response = await put('events/$eventId', data: event.toJson());
      Event newEvent = Event.fromJson(response);
      eventData[index] = newEvent;
      notifyListeners();
      return newEvent;
    } catch (error) {
      // ignore: avoid_print
      print('favoriteEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<Event> unFavoriteEvent(int eventId) async {
    try {
      int index = eventData.indexWhere((item) => item.id == eventId);
      Event event = eventData[index];
      event.favorite = false;
      final response = await put('events/$eventId', data: event.toJson());
      Event newEvent = Event.fromJson(response);
      eventData[index] = newEvent;
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
    return eventData.firstWhere((item) => item.id == eventId);
  }

  Future<void> refresh() {
    eventData.clear();
    return getListEvent();
  }

  Future<List<Event>> getFavoritesEvent() async {
    try {
      List<dynamic> response = await get('events?favorite=true');
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
      print('getFavoritesEvent: $error');
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }
}

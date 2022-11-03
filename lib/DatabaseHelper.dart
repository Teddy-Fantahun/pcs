import 'dart:async';
import 'package:pcs/PCSCandidateDataModel.dart';
import 'package:pcs/ScheduleDataModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database myDb;

  // Define a function that inserts PCSCandidate into the database
  static Future<void> insertAPCSCandidate(PCSCandidateDataModel sample) async {
    // Get a reference to the database.
    final db = myDb;

    // Insert the PCSCandidate into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same PCSCandidate is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'PCSCandidates',
      sample.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the PCS candidates from the PCSCandidates table.
  static Future<List<PCSCandidateDataModel>> getAllPCSCandidates() async {
    // Get a reference to the database.
    final db = myDb;

    // Query the table for all The PCSCandidates.
    final List<Map<String, dynamic>> maps = await db.query('PCSCandidates');

    // Convert the List<Map<String, dynamic> into a List<PCSCandidateDataModel>.
    return List.generate(maps.length, (i) {
      return PCSCandidateDataModel(
        maps[i]['firstName'],
        maps[i]['lastName'],
        maps[i]['gender'],
        maps[i]['registeredMonth'],
        maps[i]['registeredDay'],
        maps[i]['registeredYear'],
        maps[i]['id'],
        maps[i]['completedMonth'],
        maps[i]['completedDay'],
        maps[i]['completedYear']
      );
    });
  }

  static Future<void> updateAPCSCandidate(
      PCSCandidateDataModel newValue) async {
    // Get a reference to the database.
    final db = myDb;

    // Update the given PCSCandidate.
    await db.update(
      'PCSCandidates',
      newValue.toMap(),
      // Ensure that the PCSCandidate has a matching id.
      where: 'id = ?',
      // Pass the PCSCandidate's id as a whereArg to prevent SQL injection.
      whereArgs: [newValue.id],
    );
  }

  static Future<void> deleteAPCSCandidate(int id) async {
    // Get a reference to the database.
    final db = myDb;

    // Remove the PCSCandidate from the database.
    await db.delete(
      'PCSCandidates',
      // Use a `where` clause to delete a specific PCSCandidate.
      where: 'id = ?',
      // Pass the PCSCandidate's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  static Future<void> insertASchedule(ScheduleDataModel sample) async {
    // Get a reference to the database.
    final db = myDb;

    await db.insert(
      'Schedule',
      sample.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateSchedule(
      ScheduleDataModel newValue) async {
    // Get a reference to the database.
    final db = myDb;

    // Update the given schedule.
    await db.update(
      'Schedule',
      newValue.toMap(),
      // Ensure that the schedule has a matching id.
      where: 'id = ?',
      // Pass the schedule's id as a whereArg to prevent SQL injection.
      whereArgs: [newValue.id],
    );
  }


  static Future<List<ScheduleDataModel>> getSchedule() async {
    // Get a reference to the database.
    final db = myDb;

    final List<Map<String, dynamic>> maps = await db.query('Schedule');

    return List.generate(maps.length, (i) {
      return ScheduleDataModel(
          maps[i]['id'],
          maps[i]['hour'],
          maps[i]['minute'],
          maps[i]['meridian'],
          maps[i]['isMondaySelected'],
          maps[i]['isTuesdaySelected'],
          maps[i]['isWednesdaySelected'],
          maps[i]['isThursdaySelected'],
          maps[i]['isFridaySelected'],
          maps[i]['isSaturdaySelected'],
          maps[i]['isSundaySelected']
      );
    });
  }

}

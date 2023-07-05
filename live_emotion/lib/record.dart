import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

List<Map<String, dynamic>> record = [
  {
    'video_number': 0,
    'emotions': {
      'Angry': 0.0,
      'Fear': 0.0,
      'Happy': 0.0,
      'Neutral': 0.0,
      'Sad': 0.0,
      'Surprised': 0.0
    }
  }
];
var logger = Logger();
void setRecord(Map<String, dynamic> records, int video_number) {
  List<Map<String, dynamic>> filteredRecords =
      record.where((record) => record['video_number'] == video_number).toList();

  if (filteredRecords.isNotEmpty) {
    // If 'video_number' is found, update the 'emotions' in the existing record
    filteredRecords.forEach((record) {
      record['emotions'] = records;
    });
    logger.d(
        "Existing records updated with video_number $video_number: $records");
  } else {
    // If 'video_number' is not found, add a new record with the provided 'video_number' and 'records'
    record.add({'video_number': video_number, 'emotions': records});
    logger.d("New record added with video_number $video_number: $records");
  }
}

getRecord() {
  return record;
}



// Map<String, dynamic>? getHighest(int video_number) {
//   List<Map<String, dynamic>> filteredRecords =
//       record.where((record) => record['video_number'] == video_number).toList();

//   if (filteredRecords.isNotEmpty) {
//     Map<String, dynamic> emotions = filteredRecords.first['emotions'];
//     if (emotions.isNotEmpty) {
//       String highestKey = '';
//       double highestValue = double.negativeInfinity;

//       emotions.forEach((key, value) {
//         if (value > highestValue) {
//           highestValue = value;
//           highestKey = key;
//         }
//       });

//       if (highestKey.isNotEmpty) {
//         logger.d("Record is Found At $highestKey");
//         return {'emotion': highestKey, 'confidence': highestValue};
//       }
//     }
//   }
//   logger.d("Record Not found  at video ${video_number}");

//   return null;
// }

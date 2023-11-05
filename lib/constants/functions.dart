import 'dart:math';

String generateRandomItemId() {
  Random random = Random();
  int randomNumber = random.nextInt(900000) + 100000; // Generates a random number between 100000 and 999999
  return randomNumber.toString();
}
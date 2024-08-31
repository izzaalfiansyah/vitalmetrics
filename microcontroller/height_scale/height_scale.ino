#include <LiquidCrystal_I2C.h>
#include <WiFi.h>
#include <WiFiManager.h>
#include <HTTPClient.h>
#include <Arduino_JSON.h>

#define SOUND_SPEED 0.034

LiquidCrystal_I2C lcd(0x27, 16, 2);

const int trigPin = 18;
const int echoPin = 19;

String getChipID() {
  uint64_t chipid = ESP.getEfuseMac();

  String prefix = "HS-";
  String chipIDStr = String((uint16_t)(chipid >> 32), HEX) + String((uint32_t)chipid, HEX);
  chipIDStr.toUpperCase();

  return prefix + chipIDStr;
}

float getHeight() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  long duration = pulseIn(echoPin, HIGH);

  float distanceCm = duration * SOUND_SPEED / 2;

  return distanceCm;
}

void sendData(String nomor_serial, float tinggi) {
  HTTPClient http;

  http.begin("http://192.168.67.111:8000/api/realtime?tipe=tinggi");
  http.addHeader("Content-Type", "application/json");

  JSONVar json;
  json["nomor_serial"] = nomor_serial;
  json["tinggi"] = tinggi;

  int httpResponseCode = http.POST(JSON.stringify(json));

  if (httpResponseCode > 0) {
    String response = http.getString();
    Serial.println("HTTP Response code: " + String(httpResponseCode));
    Serial.println("Response: " + response);

    if (httpResponseCode == 400) {
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print(nomor_serial);
      lcd.setCursor(0, 1);
      lcd.print("belum terdaftar!");
    } else {
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("Tinggi badan:");
      lcd.setCursor(0, 1);
      lcd.print(tinggi, 2);
      lcd.print(" cm");
    }
  } else {
    Serial.println("Error on sending POST: " + String(httpResponseCode));
  }

  http.end();
}

void configModeCallback(WiFiManager *myWiFiManager) {
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Gagal terhubung");
  lcd.setCursor(0, 1);
  lcd.print("ke jaringan");
}

void setup() {
  Serial.begin(115200);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  lcd.init();
  lcd.backlight();
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Menghubungkan...");

  WiFiManager wm;
  wm.setConnectTimeout(30);
  wm.setAPCallback(configModeCallback);
  wm.autoConnect(getChipID().c_str());
}

void loop() {
  float height = getHeight();
  String chipID = getChipID();

  Serial.print("Chip ID: ");
  Serial.println(chipID);
  Serial.print("Distance (cm): ");
  Serial.println(height);

  sendData(chipID, height);

  delay(1000);
}
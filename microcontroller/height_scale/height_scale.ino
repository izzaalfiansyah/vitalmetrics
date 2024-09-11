#include <LiquidCrystal_I2C.h>
#include <WiFi.h>
#include <WiFiManager.h>
#include <HTTPClient.h>
#include <Arduino_JSON.h>

#define SOUND_SPEED 0.034

LiquidCrystal_I2C lcd(0x27, 16, 2);

const int trigPin = 18;
const int echoPin = 19;
const int ledActivePin = 2;
const int ledUnActivePin = 4;

String apiUrl = "http://192.168.202.111:8000";
JSONVar perangkat;
float height;
String chipID;

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

JSONVar getPerangkat(String nomor_serial) {
  HTTPClient http;

  http.begin(apiUrl + "/api/perangkat_user/by_serial_number/" + nomor_serial);
  http.addHeader("Content-Type", "application/json");
  http.addHeader("Accept", "application/json");
  JSONVar data;

  int httpResponseCode = http.GET();

  if (httpResponseCode == 200) {
    String response = http.getString();
    Serial.println("HTTP Response code: " + String(httpResponseCode));
    Serial.println("Response: " + response);

    data = JSON.parse(response);
  } else {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(nomor_serial);
    lcd.setCursor(0, 1);
    lcd.print("belum terdaftar!");
  }

  http.end();

  return data;
}

void sendData() {
  HTTPClient http;
  JSONVar json;
  String nomor_serial = chipID;
  float tinggi = height;

  if ((bool)perangkat["kalibrasi_tinggi_on"]) {
    http.begin(apiUrl + "/api/perangkat_user/kalibrasi?tipe=tinggi");

    json["nomor_serial"] = nomor_serial;
    json["kalibrasi_tinggi"] = tinggi;
  } else {
    http.begin(apiUrl + "/api/realtime?tipe=tinggi");

    tinggi = ((double)perangkat["kalibrasi_tinggi"]) - tinggi;

    if (tinggi < 0) {
      tinggi = 0;
    }

    json["nomor_serial"] = nomor_serial;
    json["tinggi"] = tinggi;
  }

  Serial.print("Nomor Serial: ");
  Serial.println(nomor_serial);
  Serial.print("Tinggi (cm): ");
  Serial.println(tinggi);

  http.addHeader("Content-Type", "application/json");
  http.addHeader("Accept", "application/json");

  int httpResponseCode = http.POST(JSON.stringify(json));

  if (httpResponseCode != 200) {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Terjadi");
    lcd.setCursor(0, 1);
    lcd.print("kesalahan!");
  } else {
    String response = http.getString();
    Serial.println("Response: " + response);

    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(((bool)perangkat["kalibrasi_tinggi_on"]) ? "Kalibrasi:" : "Tinggi badan:");
    lcd.setCursor(0, 1);
    lcd.print(tinggi, 2);
    lcd.print(" cm");
  }

  digitalWrite(ledActivePin, HIGH);
  digitalWrite(ledUnActivePin, LOW);

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
  pinMode(ledActivePin, OUTPUT);
  pinMode(ledUnActivePin, OUTPUT);

  digitalWrite(ledActivePin, LOW);
  digitalWrite(ledUnActivePin, HIGH);

  lcd.init();
  lcd.backlight();
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Memuat...");

  WiFiManager wm;
  wm.setConnectTimeout(30);
  wm.setAPCallback(configModeCallback);
  wm.autoConnect(getChipID().c_str());
}

void loop() {
  height = getHeight();
  chipID = getChipID();
  perangkat = getPerangkat(chipID);

  if (JSON.stringify(perangkat) != NULL) {
    sendData();
  }

  delay(1000);
}
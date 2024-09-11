#include <LiquidCrystal_I2C.h>
#include <WiFi.h>
#include <WiFiManager.h>
#include <HTTPClient.h>
#include <Arduino_JSON.h>
#include <HX711_ADC.h>


#define SOUND_SPEED 0.034

const int dtPin = 16;
const int sckPin = 4;
const int ledActivePin = 2;
const int ledUnActivePin = 4;

LiquidCrystal_I2C lcd(0x27, 16, 2);
HX711_ADC LoadCell(dtPin, sckPin);

String apiUrl = "http://192.168.202.111:8000";
JSONVar perangkat;
float weight;
String chipID;

String getChipID() {
  uint64_t chipid = ESP.getEfuseMac();

  String prefix = "WS-";
  String chipIDStr = String((uint16_t)(chipid >> 32), HEX) + String((uint32_t)chipid, HEX);
  chipIDStr.toUpperCase();

  return prefix + chipIDStr;
}

float getWeight() {
  if (LoadCell.update()) {
    return LoadCell.getData();
  } else {
    return 0.0;
  }
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
  float berat = weight;

  if ((bool)perangkat["kalibrasi_berat_on"]) {
    http.begin(apiUrl + "/api/perangkat_user/kalibrasi?tipe=berat");

    json["nomor_serial"] = nomor_serial;
    json["kalibrasi_berat"] = berat;
  } else {
    http.begin(apiUrl + "/api/realtime?tipe=berat");

    if (berat < 0) {
      berat = 0;
    }

    json["nomor_serial"] = nomor_serial;
    json["berat"] = berat;
  }

  Serial.print("Nomor Serial: ");
  Serial.println(nomor_serial);
  Serial.print("Berat (kg): ");
  Serial.println(berat);

  http.addHeader("Content-Type", "application/json");
  http.addHeader("Accept", "application/json");

  int httpResponseCode = http.POST(JSON.stringify(json));

  String response = http.getString();
  Serial.println("Response: " + response);

  if (httpResponseCode != 200) {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Terjadi");
    lcd.setCursor(0, 1);
    lcd.print("kesalahan!");
  } else {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(((bool)perangkat["kalibrasi_berat_on"]) ? "Kalibrasi:" : "Berat badan:");
    lcd.setCursor(0, 1);
    lcd.print(berat, 2);
    lcd.print(" kg");
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

  perangkat = getPerangkat(getChipID());

  LoadCell.begin();
  LoadCell.setReverseOutput();

  LoadCell.start(2000, true);
  if (LoadCell.getTareTimeoutFlag() || LoadCell.getSignalTimeoutFlag()) {
    Serial.println("Timeout, check MCU>HX711 wiring and pin designations");
  } else {
    LoadCell.setCalFactor(((double)perangkat["kalibrasi_berat"]) > 0.0 ? ((double)perangkat["kalibrasi_berat"]) : 1.0);
  }

  while (!LoadCell.update()) {
    Serial.print(".");
    delay(1000);
  }
}

void loop() {
  weight = getWeight();
  chipID = getChipID();
  perangkat = getPerangkat(chipID);
  int calStep = 1;

  while ((bool)perangkat["kalibrasi_berat_on"]) {
    perangkat = getPerangkat(chipID);

    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Proses");
    lcd.setCursor(0, 1);
    lcd.print("kalibrasi!");

    Serial.println(calStep);

    if ((int)perangkat["kalibrasi_berat"] == 0) {
      if (calStep == 1) {
        LoadCell.update();
        LoadCell.tare();

        if (LoadCell.getTareStatus() == true) {
          Serial.println("Tare complete");
          calStep += 1;
        }
      }
    } else {
      if (calStep == 2) {
        LoadCell.update();
        LoadCell.refreshDataSet();

        float calValue = LoadCell.getNewCalibration((double)perangkat["kalibrasi_berat"]);

        LoadCell.setCalFactor(calValue);

        weight = calValue;

        sendData();

        calStep = 1;
      }
    }

    delay(1000);
  }

  Serial.print("Berat (g): ");
  Serial.println(weight);
  weight = weight / 1000.0;

  if (JSON.stringify(perangkat) != NULL) {
    sendData();
  }

  delay(1000);
}
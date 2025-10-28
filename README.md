# Lapseki Belediye Mobil Uygulaması

Flutter ile MVVM mimarisi kullanılarak geliştirilmiş modern bir belediye uygulaması.

## 🚀 Özellikler

- **Ana Ekran**: Son 3 duyuru ve hızlı navigasyon butonları
- **Keşfet**: Lapseki'deki gezilecek yerler ve harita entegrasyonu
- **Etkinlikler**: Güncel ve geçmiş etkinlikler
- **Feribot**: Lapseki-Gelibolu feribot sefer saatleri
- **E-Belediye**: Belediye hizmetlerine hızlı erişim linkleri

## 🏗️ Mimari

- **MVVM (Model-View-ViewModel)** mimarisi
- **Provider** ile state management
- **Clean Architecture** prensipleri

## 📦 Bağımlılıklar

```yaml
dependencies:
  flutter_localizations:
  provider: ^6.1.0
  http: ^1.2.0
  html: ^0.15.4
  url_launcher: ^6.2.0
  intl: ^0.20.2
  logger: ^2.0.0
```

## 🎨 Tema

Uygulama, Lapseki Belediyesi logosundan ilham alan renklerle tasarlandı:
- **Mavi** (#0047AB): Ana renk
- **Kırmızı** (#E30613): Vurgu rengi
- **Yeşil** (#00843D): Accent rengi

## 🌍 Dil Desteği

- Türkçe (varsayılan)
- İngilizce

Dil değiştirme AppBar'daki dil ikonu ile yapılabilir.

## 📱 Kurulum

```bash
# Bağımlılıkları yükle
flutter pub get

# Uygulamayı çalıştır
flutter run
```

## 🔧 Geliştirme Notları

- Web scraping özellikleri MVP sonrası gerçek verilerle güncellenecektir
- Mock veriler ile çalışmaktadır
- Statik feribot saatleri kullanılmaktadır

## 🖼️ Görsel Ekleme

Ana sayfadaki slider için aşağıdaki görselleri eklemeniz gerekmektedir:

```bash
# assets/images/ klasörüne şu dosyaları ekleyin:
- millet_bahcesi.jpg (Millet Bahçesi görseli)
- canakkale_koprusu.jpg (1915 Çanakkale Köprüsü görseli)
```

Bu görseller ana sayfadaki slayt gösterisinde kullanılacaktır.

## 📝 Lisans

Bu proje Lapseki Belediyesi için geliştirilmiştir.

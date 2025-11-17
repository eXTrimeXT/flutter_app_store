## О проекте
Это мобильное приложение, разработанное на Flutter.

Приложение демонстрирует чистую архитектуру и паттерн MVVM.

## Визуализация
![1-4](G:\Programming\Dart\my_flutter_test\screens\1.png)

## Основные функции
- Экран загрузки с анимацией
- Интерактивный онбординг с переходом
- Бесконечная лента товаров с подгрузкой данных
- Pull-to-refresh для обновления контента

## Архитектура
Проект с использованием Clean Architecture и MVVM паттерна:
```
lib/
├── data/               # Слой данных
│   ├── datasources/    # Источники данных
│   ├── models/         # Модели данных
│   └── repositories/   # Репозитории
├── domain/             # Бизнес-логика
│   ├── repositories/   # Интерфейсы репозиториев
│   └── usecases/       # Use Cases
├── presentation/       # UI слой
│   └─── pages/         # Экранны
│        ├── onboarding # OnBoarding
│        ├── products/  # Продукты
│        └── splash/    # Splash
└── main.dart           # Файл запуска
```
## Технологии
- Flutter - Фреймворк для кроссплатформенной разработки
- Dart - Язык программирования
- Dio - HTTP-клиент для сетевых запросов
- Provider - State management и dependency injection
- FakeStore API - Внешний API для данных о товарах

## Используемое API
- Приложение использует FakeStoreAPI для получения данных о товарах:
- Endpoint: **https://fakestoreapi.com/products**
- Метод: GET
- Параметры: limit, offset для пагинации
- Формат данных: JSON

## Установка и запуск

Предварительные требования
- Flutter SDK
- Dart SDK
- Android Studio / IntelliJ IDEA
```
git clone https://github.com/eXTrimeXT/flutter_app_store
```
```
cd ./flutter_app_store
```
```
flutter pub get
```
Запуск
```
flutter run
```
или запуск через IDE.

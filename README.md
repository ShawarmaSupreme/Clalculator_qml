# Калькулятор (C++/QML)

## Описание проекта

Это тестовое приложение **Калькулятор**, реализованное с использованием **Qt 6 / QML**. Приложение воспроизводит внешний вид и логику калькулятора из [прототипа в Figma](https://www.figma.com/file/gJIvIUNBfA1OqMXshPFocu/Calculator_Android?node-id=0%3A1) и содержит скрытое меню.

## Основные возможности

* Базовые арифметические операции: сложение, вычитание, умножение, деление.
* Поддержка работы с числами до **25 знаков** (целых и десятичных).
* Очистка ввода (C).
* Поддержка отрицательных чисел и десятичной точки.
* **Секретное меню**: длительное нажатие (4 с) на кнопку **"="** → в течение следующих 4 секунд, ввод **«123»** открывает второй экран с надписью *«Секретное меню»* и кнопкой **Назад**.

## Скриншоты
<img width="472" alt="Снимок экрана 2025-07-06 в 20 56 35" src="https://github.com/user-attachments/assets/2ffbb0aa-9231-4dda-bc5b-f262e7a3a5e4" />
<img width="312" alt="Снимок экрана 2025-07-06 в 20 57 19" src="https://github.com/user-attachments/assets/c3f2c651-1b02-45de-a937-ec4db172b408" />
<img width="512" alt="Снимок экрана 2025-07-06 в 20 57 31" src="https://github.com/user-attachments/assets/c3794c3d-82f1-4b75-beb0-311747c72adc" />

### Требования

* Qt 6.5 + (Qt Quick, Qt Quick Controls 2)
* CMake 3.18 + **или** qmake
* С++ 17

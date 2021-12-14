#version 460

// Вычисляет цвет пикселя на экране
out vec4 fragColor;

// Данные о размере, разрешении и значении времени
uniform vec2 resolution;
uniform float time;

// Функция для вращения 2d вектора по заданному углу
vec2 rotate2D(vec2 uv, float a) {
    float s = sin(a);
    float c = cos(a);
    // Матрица вращения * на вектор
    return mat2(c, -s, s, c) * uv;
}

// Генератор случайных чисел
vec2 hash12(float t) {
    float x = float(sin(t * 3453.329));
    float y = float(sin((t + x) * 8532.732));
    // Выдаёт случайный 2D вектор
    return vec2(x, y);
}

void main() {
    // Чтобы выполнение шейдера не зависило от начального разрешения
    // Нормирован и центрирован 
    vec2 uv = (gl_FragCoord.xy - 0.5 * resolution.xy) / resolution.y;
    vec3 col = vec3(0.0);

    // Вращение системы координат
    //uv = rotate2D(uv, time);

    // Определение центра экрана
    //col += length(uv);

    // Эффектная точка
    //col += 0.01 / length(uv);

    // Пример размещения на экране
    //col += 0.01 / length(uv - vec2(0.25));

    // Задаём начальное положение
    uv = rotate2D(uv, 3.14 / 2.0);

    // Построение кардиойды
    float r = 0.17;
    for (float i = 0.0; i < 60.0; i++) {
        // Изменяет своё значение для перемещения координат кардиойды
        float factor = (sin(time) * 0.5 + 0.5) + 0.3;
        i += factor;

        // Параметрические уравнения
        float a = i/3;
        float dx = 2 * r * cos(a) - r * cos(2 * a);
        float dy = 2 * r * sin(a) - r * sin(2 * a);


        // Первый показ
        //col += 0.01 / length(uv - vec2(dx + 0.1, dy));
        
        // Без дрожания
        //col += 0.01 * factor / length(uv - vec2(dx + 0.1, dy));

        // hash12() - добавляет некоторое дрожание точкам
        col += 0.01 * factor / length(uv - vec2(dx + 0.1, dy) - 0.02 * hash12(i));
    }

    // Меняеем цвет кардиойды
    // col *= vec3(0.2, 0.8, 0.9);

    // Меняем цвет кардиойды плавно
    col *= sin(vec3(0.2, 0.8, 0.9) * time) * 0.15 + 0.25;

    fragColor = vec4(col, 1.0);
}
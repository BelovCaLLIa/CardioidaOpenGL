#version 460

// Координаты вершин из экранной плоскости (передаются из буфера вершин)
in vec3 in_position;

// Происходит вычисление вершин
void main() {
    gl_Position = vec4(in_position, 1);
}
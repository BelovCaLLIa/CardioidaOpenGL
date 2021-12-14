import moderngl_window as mglw 


# Наследуемся от WindowConfig
class App(mglw.WindowConfig):
    window_size = 1600, 900
    # Имя папки с шейдерами
    resource_dir = "programs"

    def __init__(self, **kwargs):
        # Вызов super() автоматически создаст:
        # self.ctx - Контекст OnenGL
        # self.wnd - экземпляр окна
        # self.timer - экземпляр таймера
        super().__init__(**kwargs)
        # Создаём плоскость, которая и будет экраном для отображения
        self.quad = mglw.geometry.quad_fs()
        # Загружаем файлы шейдеров
        self.prog = self.load_program(vertex_shader="vertex_shader.glsl", fragment_shader="fragment_shader.glsl")
        # Отправка данных шейдеру
        self.set_uniform("resolution", self.window_size)

    # Безопасная передача данных форме
    def set_uniform(self, u_name, u_value):
        try:
            self.prog[u_name] = u_value
        except KeyError:
            print(f"uniform: {u_name} - не используется в шейдере")

    # Метод рендера
    def render(self, time, frame_time):
        # Очищаем буфер кадра
        self.ctx.clear()
        # Отправка данных шейдеру
        self.set_uniform("time", time)
        # Рендер нового
        self.quad.render(self.prog)


if __name__ == "__main__":
    mglw.run_window_config(App)
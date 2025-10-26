# ----- Projet -----
NAME    = scop
CC      = cc
CFLAGS  = -Wall -Wextra -Werror
SRC     = main.c
OBJ     = $(SRC:.c=.o)

# ----- Backend OpenGL -----
# Choisis: glfw (par défaut) ou glut
BACKEND ?= glfw

# On utilise pkg-config pour récupérer les bons flags
PKGCONFIG = pkg-config

ifeq ($(BACKEND),glfw)
PKGS    = glfw3 glew
CFLAGS += $(shell $(PKGCONFIG) --cflags $(PKGS))
LDLIBS  = $(shell $(PKGCONFIG) --libs $(PKGS)) -lGL -lm
else ifeq ($(BACKEND),glut)
PKGS    = glut
CFLAGS += $(shell $(PKGCONFIG) --cflags $(PKGS))
LDLIBS  = $(shell $(PKGCONFIG) --libs $(PKGS)) -lGL -lm
else
$(error BACKEND must be 'glfw' or 'glut')
endif

# ----- Règles -----
all: $(NAME)

$(NAME): $(OBJ)
	$(CC) $(OBJ) -o $@ $(LDLIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

# ----- Aide -----
.PHONY: all clean fclean re deps run help
help:
	@echo "make                -> build (BACKEND=$(BACKEND))"
	@echo "make BACKEND=glfw   -> build avec GLFW+GLEW"
	@echo "make BACKEND=glut   -> build avec FreeGLUT (legacy)"
	@echo "make deps           -> installe les dépendances Ubuntu"
	@echo "make run            -> lance ./$(NAME)"

# Installe les paquets nécessaires (Ubuntu/Debian)
deps:
	sudo apt update
	sudo apt install -y build-essential pkg-config libgl1-mesa-dev
	@if [ "$(BACKEND)" = "glfw" ]; then \
		sudo apt install -y libglfw3-dev libglew-dev; \
	else \
		sudo apt install -y freeglut3-dev; \
	fi

run: all
	./$(NAME)

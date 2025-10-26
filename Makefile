# Nom de l'exécutable
NAME = scop

# Compilateur et options
CC = cc
CFLAGS = -Wall -Wextra -Werror

# Fichiers sources
SRC = main.c
OBJ = $(SRC:.c=.o)

# Chemin vers la MiniLibX
MLX_DIR = minilibx
MLX = $(MLX_DIR)/libmlx.a

# Librairies nécessaires (selon ton OS)
# Pour Linux :
LIBS = -L$(MLX_DIR) -lmlx -lXext -lX11 -lm

# Pour macOS (remplace LIBS ci-dessus par celui-ci) :
# LIBS = -L$(MLX_DIR) -lmlx -framework OpenGL -framework AppKit

# Règle par défaut
all: $(NAME)

$(NAME): $(OBJ)
	@make -C $(MLX_DIR)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJ) $(LIBS)

clean:
	rm -f $(OBJ)
	@make -C $(MLX_DIR) clean

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re

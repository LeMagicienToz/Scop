#include "main.h"

int main (void)
{
    void *mlx_ptr;
    mlx_ptr = mlx_init();
    mlx_new_window(mlx_ptr, 100, 100, "oui");
    mlx_loop(mlx_ptr);
}
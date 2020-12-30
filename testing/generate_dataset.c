#include <stdio.h>
#include <stdlib.h>

/*
 * Creates random nonsense to put into memory. I do not know if this is this
 * is the best way to test the motion estimator
 */
void generate_dataset()
{
    printf("Generating Dataset...\n");
    FILE *f = fopen("../vcs/rmem_data.hex", "w");
    FILE *g = fopen("../vcs/smem_data.hex", "w");
    srand(5);
    for(int j = 0; j < 1024; j++)
    {
        fprintf(g, "%02x\n", rand() % 2 == 0);
    }
    for(int j = 0; j < 256; j++)
    {
        fprintf(f, "%02x\n", rand() % 2 == 0);
    }
    fclose(f);
    fclose(g);
    printf("done\n");
}

int main(void)
{
    generate_dataset();
    return 0;
}





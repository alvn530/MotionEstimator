#include <stdio.h>
#include <stdlib.h>

/**
 * Software implementation of motion estimator
 **/

int r[16][16], s[31][31];
int bestDist, motionX, motionY;
int currDist, count;
char *temp;

void read_mem(void)
{
    FILE *f = fopen("../vcs/rmem_data.hex", "r");
    FILE *g = fopen("../vcs/smem_data.hex", "r");
    temp = malloc(3);
    printf("entering reference window\n");
    for(int i = 0, j = 0; fread(temp, sizeof(char) * 3, 1, f); i++)
    {
        if (i == 16)
        {
            i = 0;
            j++;
            if(j == 16)
            {
                goto here;
            }
        }
        r[j][i] = (temp[1] == '1') ? 1 : 0;
    }
    here:
    printf("entering search block\n");
    for(int i = 0, j = 0; fread(temp, sizeof(char) * 3, 1, g); i++)
    {
        if (i == 31)
        {
            i = 0;
            j++;
            if(j == 31)
            {
                goto there;
            }
        }
        s[j][i] = (temp[1] == '1') ? 1 : 0;
    }
    there:
    fclose(f);
    fclose(g);
    free(temp);
}

void start_motion_estimation(void)
{
    count = 0;
    bestDist = 0xff;
    for(int i = 0; i < 16; i++)
    {
        for(int j = 0; j < 16; j++)
        {
            currDist = 0;
            for(int a = 0; a < 16; a++)
            {
                for(int b = 0; b < 16; b++)
                {
                    if(currDist >= 0xff)
                    {
                        currDist = 0xff;
                    }
                    currDist += abs(r[a][b] - s[a + i][b + j]);
                }
                printf("currdist: %02x\n", currDist);
                if(currDist < bestDist)
                {
                    printf("updating best distance\n");
                    bestDist = currDist;
                    motionX = (count % 0x10) - 7;
                    if (motionX < 0)
                    {
                        motionX += 16;
                    }
                    motionY = (count >> 8) - 7;
                    if (motionY < 0)
                    {
                        motionY += 16;
                    }
                }
            }
            count++;
        }
    }
    printf("Best distance: %02x, MotionX: %1x, MotionY: %1x\n", bestDist, motionX, motionY);
}

int main(void)
{
    read_mem();
    start_motion_estimation();
    return 0;
}
#include <stdio.h>
void switch_mode(int new_mode) {

    if ( new_mode == 1) {
        printf("[Mode switched to Binary]\n");
    } else if (new_mode == 2) {
        printf("[Mode switched to Hexadecimal]\n");
    }
}

#include <math.h>
#include <stdio.h>

int main()
{
    double a =210.0;
    double b = 133.0;
    double c;

    c = sqrt(a * a + b * b);

    printf("Right triangle with sides %.2f and %.2f has "
        "hypotenuse of length %.2f\n", a, b, c);
}

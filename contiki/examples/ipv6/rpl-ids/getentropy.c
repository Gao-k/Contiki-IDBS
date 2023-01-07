#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Calculating Information Entropy
float GetEntropy(int a, int b)
{
  if (a == 0 && b == 0)
  {
    return 1;
  }
  else if(a > 0 && b > 0)
  {
    return -((float)a / (a + b) * log2f((float)a / (a + b)) + (float)b / (a + b) * log2f((float)b / (a + b)));
    // return 0;
  }
  else{
    return 0;
  }
}
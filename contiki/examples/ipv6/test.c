#include <stdio.h>
#include <math.h>


float GetEntropy(int a,int b)
{
   
  if(a == 0 && b == 0)
  {
    return 1;
  }else{
    return -((double)a/(a+b) * log((double)a/(a+b)) + (double)b/(a+b) * log((double)b/(a+b)))/log(2);
  }
  
}

int main()
{
    float H;
    H = GetEntropy(1,4);
    printf("%.2f",H);
    // system("pause");
    return 0;
}
#include <iostream>

//reads two integers from standard input 
//prints result of dividing first number by second
using namespace std;
int int1, int2;
 
int main () {

   while (cin >> int1 >> int2) {
      try {
         if (int2 == 0) {
            throw runtime_error("The second input must not equal 0");
         }
         cout << "Divide first by second : " << int1 / int2 << endl;
      } catch (runtime_error err) {
         cout << err.what() << "\nTry again? Enter y or n" << endl;
         char c;
         cin >> c;
         if (!cin || c == 'n') {
            break;
         }
      }
   }
   return 0;
}
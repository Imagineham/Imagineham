#include <iostream>

//Exercises 22

using namespace std;


void practice_New() {
    int x = 123; 

    int* p = new int; 
    *p = x;

    cout << "The value with automatic storage duration is " << x << endl
    << "The value with dynamic storage duration is " << *p << endl;
    delete p;
}


void array_New() {

    int* nums = new int[3];
    
    for (int i = 0; i < 3; i++) {
        nums[i] = i + 15;
        cout << "nums [ " << i << " ] = " << nums[i] << endl;
    }

    delete[] nums;

}

/*
void strings_New() {

    char** strings = new char*;
    strings[0] = "apple";
    strings[1] = "banana";
    strings[2] = "pear";

    cout << "strings[1] = " << strings[1] << endl;

    delete[] strings;
}
*/

int main() {

    practice_New(); 
    array_New();
    //strings_New();

    return 0; 
}


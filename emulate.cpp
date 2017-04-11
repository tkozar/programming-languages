#include <iostream>
#include <fstream>

#include <vector>

using namespace std;

struct emulate
{
   string inst[100]; // instruction name
   int reg[100]; // register to be editted
   int instructions[100][8]; // instructions

   int regVal[100]; // values in each register

   int current; // current instruction place
   int numReg; // number of registers added

   void display();
};


int main()
{
   emulate emul; // create type object
   ifstream fin; // create instream value

   string filename; // file name to read

   cout << "What file would you like to use? : "; // (quest2.txt / quest3.txt)
   cin >> filename;

   cout << "How many registers are needed? : "; // initializes the values in the registers
   cin >> emul.numReg;

   for (int i = 0; i < emul.numReg; i++)
   {
      cout << "Value for Register " << i + 1 << " : ";
      cin >> emul.regVal[i];
   }
   cout << endl;

   emul.current = 0; // initialize the value
   fin.open(filename.c_str()); // open file

   int count = 0;
   while(!fin.eof())
   {
      fin >> emul.inst[count];
      cout << emul.inst[count] << endl;
      
      // check if the instruction is decrement.
      // if it is take in two instructions
      if (emul.inst[count] == "DEB")
      {
	 fin >> emul.reg[count];
	 fin >> emul.instructions[count][0] >> emul.instructions[count][1];
      }

      // check if the instruction is increment
      // if it is take one instruction
      else if (emul.inst[count] == "INC")
      {
	 fin >> emul.reg[count];
	 fin >> emul.instructions[count][0];
	 emul.instructions[count][1] = 0;
      }

      // check if halt instruction
      // set i to -2 so that the loop fails
      else if (emul.inst[count] == "HALT")
      {
	 emul.reg[count] = -1;
      }

      count = count + 1;
   }

   emul.display();
   bool flag = false;

   while (flag == false)
   {
      // if increment, increment and go to an instruction
      if (emul.inst[emul.current] == "INC")
      { 
	 emul.regVal[emul.reg[emul.current]-1] += 1;
	 emul.current = emul.instructions[emul.current][0] - 1;
	 emul.display();
      }

      // if decrement, decrement and go to [1][1] if not 0, or [1][2] if it is
      else if(emul.inst[emul.current] == "DEB")
      {
	 if (emul.regVal[emul.reg[emul.current]-1] == 0)
	 { 
	    emul.current = emul.instructions[emul.current][1] - 1;
	    emul.display();
	 }
	 else 
	 {
	    emul.regVal[emul.reg[emul.current]-1] -= 1;
	    emul.current = emul.instructions[emul.current][0] - 1;
	    emul.display();
	 }
      }

      // if hault, set current to -1 to break while loop
      else if (emul.inst[emul.current] == "HALT")
      {
	 flag = true;
      }
   }
   return 0;
}

void emulate::display()
{

   for (int i = 0; i < numReg; i++)
   {
      cout << "Register " << i + 1 << " : " << regVal[i] <<endl;
   }
   cout << endl;
   cout << endl << "Press any key to continue..." <<endl <<endl;
   cin.get();
}

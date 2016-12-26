// Test3.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "SparseMatrix.cpp"
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

void parseBlock(string s)
{
	size_t pos = 0;
	char buffer[10000];
	
	string token;
	
	while ((pos = s.find('\n')) != string::npos)
	{
		token = s.substr(0, pos);
		s.erase(0, pos + 1);
		cout << token + '\n';
	}
}
int main()
{
	int i = 0;
	ios_base::sync_with_stdio(false);
	FILE * fp;
	char buff[256];
	size_t n_read;
	fp = std::fopen("URM.txt", "r");
	if (fp) {
		while ((n_read = fread(buff, 1, sizeof buff, fp)) > 0)
			fwrite(buff, 1, n_read, stdout);
	}
	fclose(fp);
	int row, column, value;
	string line, line2;
	ifstream urm ("URM.txt");

	SparseMatrix<__int8> sparse_urm(40000,167956);
	//if (urm.is_open())
	//{
	//	while (!urm.eof())
	//	{
	//		getline(urm, line, '.');
	//		//parseBlock(line);
	//		cout << line;
	//		vector<string> tokens;
	//		
	//		/*int pos = line.find('\t');
	//		row = stoi(line.substr(0, pos));
	//		line = line.substr(pos+1, line.length());
	//		pos = line.find('\t');
	//		column = stoi(line.substr(0, pos));
	//		sparse_urm.set(1, row, column);
	//		cout << row;
	//		cout << " ";
	//		cout << column;
	//		cout << "\n";*/
	//	}
	//
	//}
	cout << "Finished!";
	urm.close();
	system("pause");
	return 0;
}


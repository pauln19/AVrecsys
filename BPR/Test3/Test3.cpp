// Test3.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "SparseMatrix.cpp"
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <assert.h>

using namespace std;

SparseMatrix<float> generateSparseRandomMatrix(int num_rows, int num_cols)
{
	SparseMatrix<float> result(num_rows, num_cols);
	for (int i = 0; i < 600; i++)
	{
		int row = rand() % num_rows + 1;
		int col = rand() % num_cols + 1;
		int value = rand();
		result.set(value, row, col);
	}
	return result;
}

SparseMatrix<float> generateIdentityMatrix(int num_rows)
{
	SparseMatrix<float> result(num_rows);
	for (int i = 1; i <= num_rows; i++)
		result.set(1, i, i);
	return result;
}
int main()
{
	ios_base::sync_with_stdio(false);
	SparseMatrix<__int8> sparse_urm(40000, 167956);
	SparseMatrix<float> Y(167956, 40);
	SparseMatrix<float> Yt(40, 167956);
	SparseMatrix<float> A(40);
	SparseMatrix<float> C_u(167956);
	SparseMatrix<float> I_f(40);
	SparseMatrix<float> X(40000, 40);
	vector<float> riga(40000);
	//FILE * fp;
	//char buff[2049];
	//char *ch;
	//size_t n_read;
	//fp = std::fopen("urm.txt", "r");
	//if (fp) {
	//	while ((n_read = fread(buff, 1, sizeof buff - 1, fp)) > 0)
	//	{
	//		buff[2048] = '\0';
	//		ch = strtok(buff, "\n");
	//		while (ch != NULL)
	//		{
	//			printf("%s\n", ch);
	//			ch = strtok(NULL, "\n");
	//		}
	//			
	//	}
	//}
	//fclose(fp);
	ifstream urm ("URM.txt");

	int col, row, value;
	while (urm >> row >> col >> value)
	{
		sparse_urm.set(1, row, col);
	}

	I_f = generateIdentityMatrix(40);
	Y = generateSparseRandomMatrix(167956, 40);
	Yt = Y.transpose();
	for (int n = 0; n < 9; n++)
	{
		A = Yt.multiply(Y);
		for (int u = 1; u <= 40000; u++)
		{
			vector<__int8> urmRow = sparse_urm.getRow(u);
			for (int i = 1; i <= 167956; i++)
			{
				C_u.set(40 * urmRow[i - 1], i, i);
			}
			//Lamba is 10
			//TODO:: riga = A + Yt * C_u * Y + I_f.multiply(10);
		}
	}
	//
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
	cout << "Finished!" + NULL;
	urm.close();
	system("pause");
	return 0;
}


using System.Collections.Generic;
using System.Linq;
using System.Windows;

namespace RecSys_Framework.Classes
{
    class SparseMatrix
    {
       //Row as first index
       private Dictionary<int, Dictionary<int, double>> rowToColumn;

       //Column as first index
       private Dictionary<int, Dictionary<int, double>> columnToRow;


       private int row_n;

        private int col_n;
       public SparseMatrix()
       {
            
            this.rowToColumn = new Dictionary<int, Dictionary<int, double>>();
            this.columnToRow = new Dictionary<int, Dictionary<int, double>>();
       }

        public SparseMatrix(int rows_n, int cols_n)
        {
            this.row_n = rows_n;
            this.col_n = cols_n;
            this.rowToColumn = new Dictionary<int, Dictionary<int, double>>();
            this.columnToRow = new Dictionary<int, Dictionary<int, double>>();
        }

        public int getRowNumber()
        {
            return this.row_n;
        }

        public int getColumnNumber()
        {
            return this.col_n;
        }

        public Dictionary<int, Dictionary<int, double>> getRowToColumn()
        {
            return this.rowToColumn;
        }
        public Dictionary<int, Dictionary<int, double>> getColumnToRow()
        {
            return this.columnToRow;
        }
        //IF by rows using first data structure, otherwise using the ColumnToRow one
        public double GetValue(int firstIndex, int secondIndex, bool byRows = true)
        {
            //Array could be either the column array or the row array
            Dictionary<int, double> array = new Dictionary<int, double>();
            double v = 0;
            if (byRows)
                if (!this.rowToColumn.TryGetValue(firstIndex, out array))
                    return 0;
                else
                {
                    this.rowToColumn[firstIndex].TryGetValue(secondIndex, out v);
                    return v;
                }
            else
                if (!this.columnToRow.TryGetValue(secondIndex, out array))
                    return 0;
                else
                {
                    this.columnToRow[secondIndex].TryGetValue(firstIndex, out v);
                    return v;
                }
        }

        public double GetNNZValue(int firstIndex, int secondIndex)
        {
            return this.rowToColumn.ContainsKey(firstIndex) ? this.rowToColumn[firstIndex][secondIndex] : 0; 
        }
        public Dictionary<int, double> GetRow(int index)
        {
            Dictionary<int, double> result;
            if (this.rowToColumn.TryGetValue(index, out result))
                return result;
            else
                return new Dictionary<int, double>();
        }

        // IMPORTANTE-----PER ESSERE CONSISTENTE DOVREMMO CREARE UN ARRAY SPARSO COME CLASSE E RESTITUIRE QUELLO PERCHé IN QUESTA SITUAZIONE NOI POPOLIAMO SOLO ROW TO COLUMN PER RISPARMIARE
        //----TEMPO DI ESECUZIONE --- COSì PER GetColumnMatrix!! 
        public SparseMatrix GetRowMatrix(int index)
        {
            SparseMatrix result = new SparseMatrix(1, this.col_n);
            Dictionary<int, double> referenceRow = this.GetRow(index);
            foreach (KeyValuePair<int, double> entry in referenceRow)
            {
                result.SetValue(1, entry.Key, entry.Value);
            }
            //result.rowToColumn.Add(1, referenceRow);

            return result;
        }
        // DA MODIFICARE COME GetRowMatrix
        public SparseMatrix GetColumnMatrix(int index)
        {
            SparseMatrix result = new SparseMatrix(this.row_n,1);
            Dictionary<int, double> referenceCol = this.GetColumn(index);
            foreach (KeyValuePair<int, double> entry in referenceCol)
            {
                result.SetValue(entry.Key, 1, entry.Value);
            }

            return result;
        }
        public Dictionary<int, double> GetColumn(int index)
        {
            Dictionary<int, double> result;
            if (this.columnToRow.TryGetValue(index, out result))
                return result;
            else
                return new Dictionary<int, double>();
        }
        //Set the value in the sparse matrix, if the value is already present, it will substitute it
        public void SetValue(int row_index, int col_index, double value)
        {
            if (this.rowToColumn.ContainsKey(row_index))
                if (!this.rowToColumn[row_index].ContainsKey(col_index))
                    this.rowToColumn[row_index].Add(col_index, value);
                else
                    this.rowToColumn[row_index][col_index] = value;
            else
            {
                Dictionary<int, double> col = new Dictionary<int, double>();
                col.Add(col_index, value);
                this.rowToColumn.Add(row_index, col);
            }
            if (this.columnToRow.ContainsKey(col_index))
                if (!this.columnToRow[col_index].ContainsKey(row_index))
                    this.columnToRow[col_index].Add(row_index, value);
                else
                    this.columnToRow[col_index][row_index] = value;
            else
            {
                Dictionary<int, double> row = new Dictionary<int, double>();
                row.Add(row_index, value);
                this.columnToRow.Add(col_index, row);
            }
        }

        /**********************************************\
            OPERATORS
        ***********************************************/


        private static double dot(Dictionary<int, double> v1, Dictionary<int, double> v2)
        {
            double result = 0;
            IEnumerable<int> keysInCommon = v1.Keys.Intersect(v2.Keys);
            foreach(int i in keysInCommon)
            {
                result += v1[i] * v2[i];
            }
            
            return result;
        }
        public SparseMatrix sum(SparseMatrix m2)
        {
            Dictionary<int, Dictionary<int, double>> rtc1, rtc2 = new Dictionary<int, Dictionary<int, double>>();

            if ((this.getRowNumber() != m2.getRowNumber()) && (this.getColumnNumber() != m2.getColumnNumber()))
                return null;
            else
            {
                SparseMatrix result = new SparseMatrix(m2.getRowNumber(), m2.getColumnNumber());
                rtc1 = this.getRowToColumn();
                rtc2 = m2.getRowToColumn();
                foreach (KeyValuePair<int, Dictionary<int, double>> entry in rtc1)
                {
                    foreach (KeyValuePair<int, double> value in entry.Value)
                    {
                        result.SetValue(entry.Key, value.Key, m2.GetValue(entry.Key, value.Key) + value.Value);
                        if (m2.GetValue(entry.Key, value.Key) != 0)
                            rtc2[entry.Key].Remove(value.Key);
                        
                    }
                }
                foreach (KeyValuePair<int, Dictionary<int, double>> entry in rtc2)
                {
                    foreach (KeyValuePair<int, double> value in entry.Value)
                            result.SetValue(entry.Key, value.Key, value.Value);

                }
                return result;
            }
            
         }

        public SparseMatrix transpose()
        {
            SparseMatrix result = new SparseMatrix(this.col_n, this.row_n);
            result.columnToRow = this.rowToColumn;
            result.rowToColumn = this.columnToRow;

            return result;
        }

        public SparseMatrix mul(SparseMatrix m2)
        {
            Dictionary<int, double> rowB;
            Dictionary<int, double> row;
            if (this.col_n != m2.getRowNumber())
                return null;
            else
            {
                SparseMatrix result = new SparseMatrix(this.row_n, m2.getColumnNumber());
                for(int i = 1; i<=this.rowToColumn.Count; i++)
                {
                    row = this.rowToColumn.ElementAt(i-1).Value;
                    foreach(KeyValuePair<int, double> v in row)
                    {
                        rowB = m2.GetRow(v.Key);
                        foreach(KeyValuePair<int, double> vB in rowB)
                        {
                            //if (result.GetValue(i, vB.Key) != 0)
                            //    result.SetValue(i, vB.Key, result.GetValue(i, vB.Key) + v.Value * vB.Value);
                            //else
                            //    result.SetValue(i, vB.Key, v.Value * vB.Value);

                            result.SetValue(i, vB.Key, result.GetValue(i, vB.Key) + v.Value * vB.Value);
                            //result.SetValue(i, vB.Key, v.Value * vB.Value);
                        }
                    }
                }
                return result;
            }
        }

        public Dictionary<int, Dictionary<int, double>> cosineKNN(SparseMatrix m2, double[] norms, int shrink = 2, int knn_number=100)
        {

            Dictionary<int, double> row;
            HashSet<int> alreadyMulCols;

            if (this.col_n != m2.getRowNumber())
                return null;
            else
            {
                Dictionary<int, Dictionary<int, double>> result = new Dictionary<int, Dictionary<int, double>>();
                Dictionary<int, double> similarities;
                for (int i = 1; i <= this.rowToColumn.Count; i++)
                {
                    similarities = new Dictionary<int, double>();
                    row = this.rowToColumn.ElementAt(i - 1).Value;
                    alreadyMulCols = new HashSet<int>();
                    foreach (KeyValuePair<int, double> v in row)
                    {
                        if (m2.rowToColumn.ContainsKey(v.Key))
                        {
                            foreach (KeyValuePair<int, double> colIndex in m2.rowToColumn[v.Key])
                            {
                                if (!alreadyMulCols.Contains(colIndex.Key) && i != colIndex.Key)
                                {
                                    similarities.Add(colIndex.Key, (dot(row, m2.GetColumn(colIndex.Key))) / (norms[i - 1] * norms[colIndex.Key - 1] + shrink));
                                    alreadyMulCols.Add(colIndex.Key);
                                }

                            }
                        } 
                    }
                    result.Add(this.rowToColumn.ElementAt(i-1).Key, similarities.OrderByDescending(t=>t.Value).Take(knn_number).ToDictionary(t=>t.Key, t=>t.Value));
                }
                return result;
            }
        }
    }
}

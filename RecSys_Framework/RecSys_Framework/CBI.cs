using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using RecSys_Framework.Classes;

namespace RecSys_Framework
{
    class CBI
    {
        private static void loadParameters(SparseMatrix icm, double[] norms)
        {
            int i = 0;
            StreamReader icm_reader = new StreamReader(File.OpenRead("../UserICM.txt"));
            StreamReader norms_reader = new StreamReader(File.OpenRead("../normsUCM100.txt"));
            while (!icm_reader.EndOfStream)
            {
                string line = icm_reader.ReadLine();
                string[] camps = line.Split('\t');
                icm.SetValue(Int32.Parse(camps[0]), Int32.Parse(camps[1]), 1);
                icm.SetValue(Int32.Parse(camps[0]), Int32.Parse(camps[1]), 1);
            }
            icm_reader.Close();
            while (!norms_reader.EndOfStream)
            {
                string line = norms_reader.ReadLine();
                norms[i] = Double.Parse(line);
                i++;
            }
            norms_reader.Close();
        }

        static void Main(string[] args)
        {
            SparseMatrix ucm = new SparseMatrix(40000, 100);
            StreamWriter fileOut = new StreamWriter("../similarities.txt");
            Dictionary<int, Dictionary<int, double>> userSims = new Dictionary<int, Dictionary<int, double>>();
            //double[,] a;
            double[] norms = new double[63446];
            loadParameters(ucm, norms);
            Console.WriteLine("Finished to read");
            userSims = ucm.cosineKNN(ucm.transpose(), norms, 20, 80);
            foreach(KeyValuePair<int, Dictionary<int, double>> entry in userSims)
            {
                foreach (KeyValuePair<int, double> v in entry.Value)
                    fileOut.WriteLine(String.Format("{0}\t{1}\t{2}", entry.Key, v.Key, v.Value));
            }
            fileOut.Close();
            Console.WriteLine("FINISHED BITCHES");
            Console.Read();
            
        }
    }
}

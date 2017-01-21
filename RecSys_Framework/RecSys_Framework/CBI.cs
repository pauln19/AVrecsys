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
        private static void loadParameters(SparseMatrix icmActive, SparseMatrix icmInteracted, double[] normsInteracted, double[] normsActive)
        {
            int i = 0;
            StreamReader icm_active_reader = new StreamReader(File.OpenRead("../icm.txt"));
            StreamReader norms_reader = new StreamReader(File.OpenRead("../normsActive.txt"));
            StreamReader norms_interacted_reader = new StreamReader(File.OpenRead("../normsInteracted.txt"));
            StreamReader icm_interacted_reader = new StreamReader(File.OpenRead("../icmInteracted.txt"));
            while (!icm_active_reader.EndOfStream)
            {
                string line = icm_active_reader.ReadLine();
                string[] camps = line.Split('\t');
                icmActive.SetValue(Int32.Parse(camps[0]), Int32.Parse(camps[1]), 1);
                icmActive.SetValue(Int32.Parse(camps[0]), Int32.Parse(camps[1]), 1);
            }
            icm_active_reader.Close();

            while (!icm_interacted_reader.EndOfStream)
            {
                string line = icm_interacted_reader.ReadLine();
                string[] camps = line.Split('\t');
                icmInteracted.SetValue(Int32.Parse(camps[0]), Int32.Parse(camps[1]), 1);
                icmInteracted.SetValue(Int32.Parse(camps[0]), Int32.Parse(camps[1]), 1);
            }
            icm_interacted_reader.Close();

            while (!norms_reader.EndOfStream)
            {
                string line = norms_reader.ReadLine();
                normsActive[i] = Double.Parse(line);
                i++;
            }
            norms_reader.Close();
            i = 0;
            while (!norms_interacted_reader.EndOfStream)
            {
                string line = norms_interacted_reader.ReadLine();
                normsInteracted[i] = Double.Parse(line);
                i++;
            }
            norms_interacted_reader.Close();
        }

        static void Main(string[] args)
        {
            SparseMatrix icmActive = new SparseMatrix(63446, 900);
            SparseMatrix icmInteracted = new SparseMatrix(156049, 900);
            StreamWriter fileOut = new StreamWriter("../similarities.txt");
            Dictionary<int, Dictionary<int, double>> userSims = new Dictionary<int, Dictionary<int, double>>();
            //double[,] a;
            double[] normsActive = new double[63446];
            double[] normsInteracted = new double[156049];
            loadParameters(icmActive, icmInteracted, normsInteracted, normsActive);
            Console.WriteLine("Finished to read");
            userSims = icmInteracted.cosineKNN(icmActive.transpose(), normsInteracted, normsActive, 20, 80);
            foreach (KeyValuePair<int, Dictionary<int, double>> entry in userSims)
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

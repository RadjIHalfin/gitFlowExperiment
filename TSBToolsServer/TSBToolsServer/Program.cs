using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TSB.Lib.Program.CommandLine;
//using System.Threading.Tasks;

namespace TSBLib_Test
{
    class ConsoleProgram
    {
        /*
        //эта настройка должна совпадать с настройкой проекта.
        //иначе не будет возможности подгрузить встроенные ресурсы
        static string getDefaultNamespace() { return "TSB.Lib"; }
        */
        static void Main(string[] args)
        {
            //process.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;

            /*
            //Это путь к Exe и его каталогу
            string assmblypath = System.Reflection.Assembly.GetEntryAssembly().Location;
            string appPath = System.IO.Path.GetDirectoryName(assmblypath);
            Console.WriteLine(assmblypath);
            Console.WriteLine(appPath);
            */


            ParametersSchemaLoader cl = new ParametersSchemaLoader();

            Console.ReadLine();
        }

    }


}

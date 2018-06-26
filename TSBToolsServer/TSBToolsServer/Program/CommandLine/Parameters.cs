using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Xml.Serialization;
using TSB.Lib.Program.CommandLine.Schema;
using TSB.Lib.Program.Resource;

namespace TSB.Lib.Program.CommandLine
{
    /// Класс для описания и парсинга параметров командной строки
    class CommandLine
    {
        const string cmdLineSchemaResourceName = "CommandLineParametersSchema.xml";
        //const string cmdLineSchemaXSDResourceName = "Program/CommandLine/ParametersSchema.xsd";
        //const string cmdLineSchemaXSLTResourceName = "Program/CommandLine/ParametersSchema.xslt";

        private ParametersSchema schema;

        public CommandLine()
        {
            XmlSerializer serializer = new XmlSerializer(typeof(ParametersSchema));
            string cmdLineSchemaXml = EmbeddedResourceHelper.GetEmbeddedResourceText(cmdLineSchemaResourceName);

            using (TextReader reader = new StringReader(cmdLineSchemaXml))
            {
                schema = (ParametersSchema)serializer.Deserialize(reader);
            }

            //Console.WriteLine(schema.Commands.Count());


            /*
                        XDocument cmdLineSchemaXmlDoc = XDocument.Parse(cmdLineSchemaXml);
                        IEnumerable<ChemieComponent> result = from c in doc.Descendants("Command")
                                                              select new Command()
                                                              {
                                                                  Name = (string)c.Attribute("name"),
                                                                  Id = (string)c.Attribute("id"),
                                                                  MolarMass = (double)c.Attribute("molarmass")
              */
        }

    }

    /// Класс содержит описание команды со всеми вариантами параметров и опций.
    /// Так же класс выполняет парсинг параметров и опций
    class Command
    {
        int Run()
        {
           throw new NotImplementedException();
        }

    }

}

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
    public class SyntaxLoader
    {
        const string cmdLineSchemaResourceName = "ParametersSchema.xml";
        //const string cmdLineSchemaXSDResourceName = "ParametersSchema.xsd";
        //const string cmdLineSchemaXSLTResourceName = "ParametersSchema.xslt";

        private ParametersSchema schema;

        public SyntaxLoader()
        {
            XmlSerializer serializer = new XmlSerializer(typeof(ParametersSchema));
            string cmdLineSchemaXml = EmbeddedResourceHelper.GetEmbeddedResourceText(typeof(SyntaxLoader), cmdLineSchemaResourceName);

            using (TextReader reader = new StringReader(cmdLineSchemaXml))
            {
                schema = (ParametersSchema)serializer.Deserialize(reader);
            }

            
            foreach (Schema.Command cmd in schema.Commands)
            {
                Console.Write("id=" + cmd.Id);
                Console.Write(" name=" + cmd.Name);
                //Console.Write(" description=" + cmd.Description);
                Console.WriteLine();
            }


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

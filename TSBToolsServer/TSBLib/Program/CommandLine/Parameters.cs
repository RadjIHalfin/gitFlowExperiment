using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.Xsl;
using TSB.Lib.Program.Resource;

namespace TSB.Lib.Program.CommandLine
{
    /// Класс для описания и парсинга параметров командной строки
    public class ParametersSchemaLoader
    {
        const string cmdLineSchemaResourceName = "ParametersSchema.xml";
        const string cmdLineSchemaXSDResourceName = "ParametersSchema.xsd";
        const string cmdLineSchemaXSLTResourceName = "ParametersSchema.xslt";

        private ParametersSchema schema;

        public ParametersSchemaLoader()
        {
            string cmdLineSchemaXml = EmbeddedResourceHelper.GetEmbeddedResourceText(typeof(ParametersSchemaLoader), cmdLineSchemaResourceName);
            string cmdLineSchemaXsd = EmbeddedResourceHelper.GetEmbeddedResourceText(typeof(ParametersSchemaLoader), cmdLineSchemaXSDResourceName);
            string cmdLineSchemaXsl = EmbeddedResourceHelper.GetEmbeddedResourceText(typeof(ParametersSchemaLoader), cmdLineSchemaXSLTResourceName);

            XmlSerializer serializer = new XmlSerializer(typeof(ParametersSchema));

            //Загрузка, валидация и десериализация XML
            XmlReaderSettings settings = new XmlReaderSettings();
            using (XmlReader xsdReader = XmlReader.Create(new StringReader(cmdLineSchemaXsd)))
            {
                settings.Schemas.Add("", xsdReader);
            }
            settings.ValidationType = ValidationType.Schema;

            using (XmlReader xmlReader = XmlReader.Create(new StringReader(cmdLineSchemaXml), settings))
            {
                schema = (ParametersSchema)serializer.Deserialize(xmlReader);
            }

            //Загрузка XSLT
            XslCompiledTransform xslt = new XslCompiledTransform();
            using (XmlReader xslReader = XmlReader.Create(new StringReader(cmdLineSchemaXsl)))
            {
                xslt.Load(xslReader);

                foreach (command cmd in schema.commands.command)
                {
                    Console.Write("id=" + cmd.id);
                    Console.Write(" argName=" + cmd.argName);
                    Console.WriteLine(" helpMessage:");

                    //XSL Трансформация с параметрами
                    XsltArgumentList arguments = new XsltArgumentList();
                    //string programName = System.Reflection.Assembly.GetExecutingAssembly().GetName().Name;

                    string programName = System.Reflection.Assembly.GetEntryAssembly().Location;
                    programName = programName.Substring(programName.LastIndexOf(@"\")+1);

                    arguments.AddParam("programName", "", programName);
                    arguments.AddParam("commandName", "", cmd.argName);

                    TextWriter textWriter = new StringWriter();
                    using (XmlReader xmlReader = XmlReader.Create(new StringReader(cmdLineSchemaXml), settings))
                    {
                        xslt.Transform(xmlReader, arguments, textWriter);
                    }

                    Console.WriteLine(textWriter.ToString());
                    Console.WriteLine();
                }
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

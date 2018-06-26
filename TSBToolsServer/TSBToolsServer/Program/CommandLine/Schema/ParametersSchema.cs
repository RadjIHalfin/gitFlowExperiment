using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Xml.Serialization;

namespace TSB.Lib.Program.CommandLine.Schema
{
    [XmlRoot("ParametersSchema")]
    public class ParametersSchema
    {
//        [XmlArrayItem("command")]
//        public Command[] Commands { get; set; }
    }

    public class Command
    {
        [XmlElement("id")]
        public string Id { get; set; }

        [XmlElement("name")]
        public string Name { get; set; }

        [XmlElement("desciption")]
        public XDocument Description { get; set; }
    }
}

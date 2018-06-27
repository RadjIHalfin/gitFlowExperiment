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
        [XmlElement("command")]
        public Command[] Commands;

        /*
        [XmlArray("ParametersSchema")]
        [XmlArrayItem("command")]
        public List<Command> Commands;
        */
    }

    public class Command
    {
        [XmlAttribute("id")]
        public string Id { get; set; }

        [XmlAttribute("name")]
        public string Name { get; set; }

        [XmlElement("description")]
        public Description description;
        
    }

    public class Description
    {
        [XmlText]
        public string Text { get; set; }
    }


}

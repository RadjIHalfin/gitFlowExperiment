using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Tsb.Lib.Program
{
    public interface IProgramCommand
    {
        void Run();
    }

    public abstract class ProgramCommand
    {
        public class Option
        {
            public enum ValueType { NoValue, NoSpaceValue, AllowedValues /*, QuotedValue */ };

            private ValueType valueType;
            private List<string> allowedValues;

            Option(string name) { Init(name, ValueType.NoValue, null); }

            //пока только ValueType.NoSpaceValue
            Option(string name, ValueType valueType)
            {
                if (!valueType.Equals(ValueType.NoSpaceValue)
                    /* && ! valueType.Equals(ValueType.QuotedValue) */
                    )
                {
                    throw new System.NotSupportedException("Invalid ProgramCommand Option argument.");
                }

                Init(name, valueType, null);
            }

            Option(string name, List<string> allowedValues)
            {
                Init(name, ValueType.AllowedValues, allowedValues);
            }

            private void Init(string name, ValueType valueType, List<string> allowedValues)
            {
                if (valueType.Equals(ValueType.AllowedValues)
                    && allowedValues != null)
                {
                    throw new System.NotSupportedException("Incompatible Arguments");
                }

                this.Name = name;
                this.valueType = valueType;
                this.allowedValues = allowedValues;
            }

            public string Name { get; private set; }

            public string Value {
                get
                {
                    if (valueType.Equals(ValueType.NoValue))
                    {
                        throw new System.NotSupportedException("No value in this ProgramCommand Option.");
                    }
                    return Value;
                }

                private set { }

            }

            public static string OptionNamePrefix { get; set; } = "-";
            public static string OptionValuePrefix { get; set; } = "=";
            /* public string OptionValueQuote { get; set; } = "\""; */

            public bool TryParse(string optionArg)
            {
                bool returnValue = false;

                Regex regex = new Regex(@"^-(\w+)(:?)(\w)$");
                Match match = regex.Match(optionArg);

                if (!match.Success) return false;

                if (match.Groups[1].Equals(this.Name))
                {
                    switch (valueType)
                    {
                        case ValueType.NoValue:
                            if (match.Groups.Count != 1)
                            {
                                throw new System.NotSupportedException("Unexpected Option value");
                            }
                            else
                            {
                                dddddd
                            }
                    
                            break;
                        case ValueType.NoSpaceValue:
                        case ValueType.AllowedValues:
                        default:
                            throw new System.NotSupportedException("Такого не должно быть.");
                    }

                }

                return returnValue;
            }

        }

        public ProgramCommand()
        {
        }


        public CommandLinePattern(string name)
        {
                this.Name = name;
                this.Parameters = new List<string>();
                this.Options = new List<string>();
        }
            public string Name { get; set; }

            public List<string> Parameters { get; set; }

            public List<string> Options { get; set; }

        }
    }
}

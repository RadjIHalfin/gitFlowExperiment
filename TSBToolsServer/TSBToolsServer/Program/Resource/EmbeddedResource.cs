using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;

namespace TSB.Lib.Program.Resource
{
    /// <summary>
    /// Класс для облегчения работы с ресурсами.
    /// Частично заимствовано отсюда
    /// http://www.vcskicks.com/embedded-resource.php
    /// </summary>
    static class EmbeddedResourceHelper
    {
        /// <summary>
        /// Конструирует правильную строку ресурса.
        /// Функция позволяет указывать resourceName так "Folder/file.txt";
        /// </summary>
        private static string FormatResourceName(Assembly assembly, string resourceName)
        {
            return assembly.GetName().Name + "." + resourceName.Replace(" ", "_")
                                                               .Replace("\\", ".")
                                                               .Replace("/", ".");



        }

        public static string GetEmbeddedResourceText(string resourceName)
        {
            return GetEmbeddedResourceText(resourceName, typeof(EmbeddedResourceHelper).Assembly);
        }

        public static string GetEmbeddedResourceText(string resourceName, Assembly assembly)
        {
            resourceName = FormatResourceName(assembly, resourceName);
            using (Stream resourceStream = assembly.GetManifestResourceStream(resourceName))
            {
                if (resourceStream == null)
                {
                    throw new FileLoadException("Ошибка загрузки файла из ресурсов.", resourceName);
                    //return null;
                }

                using (StreamReader reader = new StreamReader(resourceStream))
                {
                    return reader.ReadToEnd();
                }
            }
        }

    }
}

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;

namespace TSB.Lib.Program.Resource
{
    /// <summary>
    /// Класс для облегчения работы с внедренными в сборку ресурсами.
    /// </summary>
    public static class EmbeddedResourceHelper
    {
        /// <summary>
        /// Конструирует правильную строку ресурса.
        /// Функция позволяет указывать resourceName м пробелами
        /// Подкаталоги считаются дочерними NS.
        /// Так физический путь: дефолтный.namespace.сборки/папка1/папка2/файл_ресурса
        /// соответствует:
        ///     resourceNamespace = дефолтный.namespace.сборки.папка1.папка2
        ///     resourceName = файл_ресурса
        /// Стоит располагать классы потребители ресурсов в том же каталоге проекта, что и ресурс.
        /// Тогда classNamespace будет совпадать resourceNamespace.
        /// </summary>
        private static string FormatResourceName(string resourceNamespace, string resourceName)
        {
            return resourceNamespace + "." + resourceName.Replace(" ", "_");
        }

        /// <summary>
        /// получение ресурса расположенного в той же сборке и неймспейсе, что и указаный тип
        /// </summary>
        /// <param name="type">тип (тип класса)</param>
        /// <param name="resourceName">имя файла ресурса</param>
        /// <returns>текст ресурса</returns>
        public static string GetEmbeddedResourceText(Type type, string resourceName)
        {
            return GetEmbeddedResourceText(type.Assembly, type.Namespace, resourceName);
        }

        public static string GetEmbeddedResourceText(Assembly assembly, string resourceNamespace, string resourceName)
        {
            resourceName = FormatResourceName(resourceNamespace, resourceName);
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

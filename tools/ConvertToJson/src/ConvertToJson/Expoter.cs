using System.Collections.Generic;
using System.IO;
using Newtonsoft.Json;

/// <summary>
/// 書込みクラス
/// </summary>
class Expoter
{
    /// <summary>
    /// Jsonをファイルに保存
    /// </summary>
    public void SaveJsonToFile(Dictionary<string, object> _dict)
    {
        foreach (var _object in _dict)
        {
            string name = Path.Combine(Directory.GetCurrentDirectory(),Path.ChangeExtension(_object.Key, ".json"));
            using (Stream s = new FileStream(name, FileMode.Create))
            {

                string jsonString = JsonConvert.SerializeObject(_object.Value, Formatting.Indented);
                SaveToStream(s, jsonString);
            }
        }
    }

    /// <summary>
    /// ストリームに保存
    /// </summary>
    /// <param name="_name"></param>
    protected void SaveToStream(Stream _stream, object _object)
    {
        using (TextWriter tw = new StreamWriter(_stream))
        {
            tw.Write(_object);
        }

    }
};

using System;
using System.Collections.Generic;

/// <summary>
/// メイン
/// </summary>
class Program
{
    /// <summary>
    /// メイン
    /// </summary>
    /// <param name="args"></param>
    static void Main(string[] args)
    {
        // 引数チェック
        if (args.Length == 0)
        {
            Console.Error.WriteLine("読み込むファイルを指定またはドラッグ＆ドロップをしてください。");
            Console.Error.WriteLine("例)ConvertToJson FilePath");
        }

        // ファイルから読み込み
        Dictionary<string,object> csvDict = ImportFromFile(args[0]);

        // ファイルに保存
        ExportToFile(csvDict);
    }

    /// <summary>
    /// ファイルから読み込み
    /// </summary>
    /// <param name="_name"></param>
    /// <returns></returns>
    public static Dictionary<string,object> ImportFromFile(string _name)
    {
        Impoter impoter = new Impoter();

        return impoter.ImportXlsxFromFile(_name);
    }

    /// <summary>
    /// CSV文字列からJson文字列に変換
    /// </summary>
    /// <param name="_csvString"></param>
    /// <returns></returns>
    public static string ConvertJsonStringToCsvString(string _csvString)
    {
        return _csvString;
    }

    /// <summary>
    /// ファイルに保存
    /// </summary>
    /// <param name="_name"></param>
    /// <param name="_dict"></param>
    public static void ExportToFile(Dictionary<string,object> _dict)
    {
        Expoter expoter = new Expoter();
        expoter.SaveJsonToFile(_dict);
    }
}

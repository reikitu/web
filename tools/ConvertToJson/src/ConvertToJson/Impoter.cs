using System;
using System.Collections.Generic;
using System.IO;
using ClosedXML.Excel;

/// <summary>
/// 読み込みクラス
/// </summary>
class Impoter
{
    /// <summary>
    /// ファイルから読み込み
    /// </summary>
    /// <param name="_name"></param>
    /// <returns></returns>
    public Dictionary<string, object> ImportXlsxFromFile(string _name)
    {
        // シートごとのデータを格納
        Dictionary<string, object> dataList = new Dictionary<string, object>();
        // エクセルの読み込み
        using (XLWorkbook xlsx = new XLWorkbook(_name))
        {
            // すべてのワークシートを回す
            foreach (var worksheet in xlsx.Worksheets)
            {
                // 行数の取得
                int rowLength = worksheet.LastRowUsed().RowNumber();
                int columnLength = worksheet.LastColumnUsed().ColumnNumber();
                // 行ごとにデータを生成
                List<Dictionary<string, object>> data= new List<Dictionary<string, object>>();
                bool isHedder = true;
                for (int i = 1; i <= rowLength; i++)
                {
                    Dictionary<string, object> items= new Dictionary<string, object>();
                    for (int j = 1; j <= columnLength; j++)
                    {
                        // #付きは読み込まない
                        if (worksheet.Cell(i, j).Value.ToString().Contains("#"))
                        {
                            break;
                        }
                        // 初めの1行目は読み込まない
                        if (isHedder)
                        {
                            isHedder = false;
                            break;
                        }
                        items.Add(worksheet.Cell(2, j).Value.ToString(), worksheet.Cell(i, j).Value);
                        Console.Write(worksheet.Cell(i, j).Value);
                    }
                    if (items.Count != 0) 
                    {
                        data.Add(items);
                    }
                    Console.WriteLine("");
                }
                dataList.Add(worksheet.Name, data);
            }
        }
        return dataList;
    }

    /// <summary>
    /// ストリームから読み込み
    /// </summary>
    /// <param name="_stream"></param>
    /// <returns></returns>
    protected string InmortFromStream(Stream _stream)
    {
        using (TextReader tr = new StreamReader(_stream))
        {
            return tr.ReadToEnd();
        }
    }
};

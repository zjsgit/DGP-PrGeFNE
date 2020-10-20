package cn.csu.bio.utls;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

//对JSON格式操作的包
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class FileUtil {
	
	/*
	 * 
	 * 将数据从文件中按行读取
	 */
	public static List<String> readFile2List(String path) {
		
		List<String> list = new ArrayList<>();
		try {
			Scanner scanner = new Scanner(Paths.get(path));
			while (scanner.hasNextLine()) {
				list.add(scanner.nextLine());
			}
			scanner.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return list;
		
	}
	
	/*
	 * 
	 * 将数据从文件中按行读取
	 */
	public static void writeList2File(String path, List<String> dataList) {
		
		File file = new File(path);
        if (file.exists()) {
        	System.out.println("文件已存在");
        } else {
            try {
                File fileParent = file.getParentFile();
                if (fileParent != null) {
                    if (!fileParent.exists()) {
                        fileParent.mkdirs();
                    }
                }
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

		try {
			PrintWriter writer = new PrintWriter(path);
			for (String str : dataList) {
				writer.println(str);
			}
			writer.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
	}
	
	
	/*
	 * 
	 */
	public static String jsonToFile(JSONArray json) {
		String ok = "OK";
		
		
		
		
		
		return ok;
		
	}

}

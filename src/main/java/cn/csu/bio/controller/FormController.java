package cn.csu.bio.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cn.csu.bio.utls.*;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

@Controller
public class FormController {
	
	@RequestMapping(value="/queryDis", method=RequestMethod.POST)
	public ModelAndView visulize(HttpServletRequest request) {
	
		ModelAndView modelAndView = new ModelAndView();
		
		
		String disId = request.getParameter("disease");
//		System.out.println("提交的疾病ID为"+ disId);
		String disIdLowerCase = disId.toLowerCase();
		
		int number = Integer.valueOf(request.getParameter("number"));
//		System.out.println(number);
		String enrichment = request.getParameter("enrichment");
//		System.out.println(enrichment );
		
		String path = request.getSession().getServletContext().getRealPath("/file");
		
		
//		-----------------------------------------------------------------------------------------------------
//		读取候选基因
		String path1 = path + "/DiseaseNames.txt";
		List<String> diseaseNames = FileUtil.readFile2List(path1);
//		String selectDis = "C1970051";
		String UMLS = "";
		for(String di:diseaseNames){
			String [] dises = di.toLowerCase().split("\t");
			for (int i = 0; i < dises.length; i++) {
				if(dises[i].equals(disIdLowerCase)) {
					System.out.print(dises[0] + "\n");
					UMLS = dises[0];
					break;
				}
			}
			
		}
		
		if(UMLS.equals("") | UMLS.equals(null)) {
			modelAndView.setViewName("error");
			return modelAndView;
		}
		 
		String path2 = path + "/Disease2Genes.txt";
		List<String> disease2Genes = FileUtil.readFile2List(path2);
		int rank = 1;
		JSONArray genes = new JSONArray();
		List <String> genesList = new ArrayList<String>();
		
		for(String di:disease2Genes){
			String [] dises = di.split("\t");
			if(dises[0].toLowerCase().equals(UMLS)) {
				JSONObject data = new JSONObject();
//				System.out.print(di + "\n");
				data.put("gene", dises[1] );
				data.put("rank", rank);
				genesList.add(dises[1] + "\t"+ rank);
				
				genes.add(data);
				rank += 1;
				
//				如果rank大于所需要的数量，跳出循环
				if(rank > number) { 
					break;
				}
			}
		}
		
//		System.out.println(genes.toString());
		
//		---------------------------------------------------------------------------------------------
//		读取enrichment数据
		String path3 = path + "/enrichment/" + number + "_" + enrichment + ".txt";
//		System.out.println(path3);
		JSONArray pValue = new JSONArray();
		List <String> pValueList = new ArrayList<String>();
		
		int index = 1;
		
		List<String> enrichment_result = FileUtil.readFile2List(path3);
		for(String line: enrichment_result) {
			if(!line.startsWith("#")) {
				
				String [] con = line.split("\t");
				
				if(con[0].toLowerCase().equals(UMLS)) {
									
					JSONObject data2 = new JSONObject();
					data2.put("pathway", con[1] );
					data2.put("Pvalue", con[2] );
					data2.put("adjPvalue", con[3]);
					pValueList.add(con[1] + "\t" + con[2] + "\t" + con[3]);
					
					pValue.add(data2);
					index += 1;
					if(index > 10) {
						break;
					}
					
				}// end if
				
				
			}// end if
			
		}//end for
		
		//------------------------------------------------------------------------
		HttpSession session = request.getSession();  
        
		String path4 =  UMLS + "_" + number + "_" + enrichment + ".txt";
		session.setAttribute("enrichmentPath", path4);  
		FileUtil.writeList2File( path + "/download/" + path4, pValueList);
		
		String path5 =  UMLS + "_" + number + ".txt"; 
		session.setAttribute("genesPath", path5);  
		FileUtil.writeList2File(path + "/download/" + path5, genesList);
		//------------------------------------------------------------------------
		
		
		modelAndView.addObject("genes", genes);
		modelAndView.addObject("disease", disId);
		modelAndView.addObject("enrichment",  pValue);
		modelAndView.addObject("type", enrichment.toUpperCase());
		
		modelAndView.setViewName("result");
		return modelAndView;
	}

	@RequestMapping(value="/downloadRe", method=RequestMethod.GET)
	public void downloadResult(
			@RequestParam(value = "msg", required = false, defaultValue = "null") String str,
			HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession(); 
		
		String path1 = session.getAttribute("enrichmentPath").toString();
		String path2 = session.getAttribute("genesPath").toString();
		
		String basePath = request.getSession().getServletContext().getRealPath("/file/download/");
		String newPath = "";
		
		System.out.println(str);
		if (str.equals("genes")) {
			newPath = basePath + path2;
		}else {
			newPath = basePath + path1;
		}
		
		System.out.println(newPath);
		
		InputStream inputStream=null;
        try {
            File file = new File(newPath);
            inputStream=new FileInputStream(file);            
            try {
     	       byte[] buffer = new byte[4096];
     	        int readLength = 0;
     	        response.addHeader("Content-Disposition", "attachment;filename=" + new String(file.getName().getBytes()));
     	        OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
     	        while ((readLength=inputStream.read(buffer)) > 0) {
     	            byte[] bytes = new byte[readLength];
     	            System.arraycopy(buffer, 0, bytes, 0, readLength);
     	            toClient.write(bytes);
     	        }
     	        inputStream.close();
     	        toClient.flush();
     	        toClient.close();
     	    }catch (Exception e){
     	        e.printStackTrace();
     	    }
            
        }catch (Exception e){
        	e.printStackTrace();
            System.out.println("出现异常了，请稍后重试");
        }

	
	}
	
	
}

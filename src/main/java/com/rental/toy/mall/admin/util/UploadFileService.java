package com.rental.toy.mall.admin.util;

import java.io.File;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class UploadFileService {

	public String upload(MultipartFile file) {

		boolean result = false;
		
		// File ¿˙¿Â
		String fileOriName = file.getOriginalFilename();
		String fileExtension = 
				fileOriName.substring(fileOriName.lastIndexOf("."), fileOriName.length());
		String uploadDir = "C:\\toy\\upload";
		
		UUID uuid = UUID.randomUUID();
		String uniqueName = uuid.toString().replaceAll("-", "");
		
		File saveFile = new File(uploadDir + "\\" + uniqueName + fileExtension);
		
		if (!saveFile.exists())
			saveFile.mkdirs();
		
		try {
			file.transferTo(saveFile);
			result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		if (result) {
			return uniqueName + fileExtension;
		} else {
			return null;
		}
		
	}
	
}

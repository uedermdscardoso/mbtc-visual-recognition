package dev.uedercardoso.mbtc.web.services;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ibm.cloud.sdk.core.security.IamAuthenticator;
import com.ibm.watson.visual_recognition.v3.VisualRecognition;
import com.ibm.watson.visual_recognition.v3.model.ClassResult;
import com.ibm.watson.visual_recognition.v3.model.ClassifiedImage;
import com.ibm.watson.visual_recognition.v3.model.ClassifiedImages;
import com.ibm.watson.visual_recognition.v3.model.ClassifierResult;
import com.ibm.watson.visual_recognition.v3.model.ClassifyOptions;

@Service
public class VisualRecognitionService {


	@Value("${watson.visual-recognition.api-key}")
	public String apikey;
	
	@Value("${watson.visual-recognition.url}")
	public String url;
	
	@Value("${watson.visual-recognition.model-id}")
	public String modelId;
	
	public String classify(MultipartFile file) throws Exception {
		
		try {
			IamAuthenticator authenticator = new IamAuthenticator(apikey);
			VisualRecognition visualRecognition = new VisualRecognition("2018-03-19", authenticator);
			visualRecognition.setServiceUrl(url);
	
			File image = convert(file);
			InputStream imagesStream = new FileInputStream(image);

			ClassifyOptions classifyOptions = new ClassifyOptions.Builder()
			  .imagesFile(imagesStream)
			  .imagesFilename(file.getOriginalFilename())
			  .addClassifierId("DetecçãodePragas_1242988900") //model id
			  //.classifierIds(Arrays.asList(modelId))
			  .build();
			
			ClassifiedImages result = visualRecognition.classify(classifyOptions).execute().getResult();
			
			List<ClassifiedImage> classifiedImageList = result.getImages();
			
			if(classifiedImageList.size() > 0) {
				List<ClassifierResult> classifierResultList = classifiedImageList.get(0).getClassifiers();
				
				if(classifierResultList.size() > 0) {
					List<ClassResult> classResultList = classifierResultList.get(0).getClasses();
					
					if(classResultList.size() > 0) {
						
						String classPredicted = classResultList.get(0).getXClass();
						
						return classPredicted;
					}
					
				}
			}
			
			return String.valueOf("");
			
		} catch(Exception e) {
			throw new Exception(e);
		}
		
	}
	
	private File convert(MultipartFile file) throws IOException {
		
		String filename = file.getOriginalFilename();
		String extension = filename.substring(filename.lastIndexOf('.'), filename.length());
		
		File convFile = new File(System.getProperty("java.io.tmpdir")+"/"+UUID.randomUUID()+extension);
		file.transferTo(convFile);
		return convFile;
	}
	
}

package dev.uedercardoso.mbtc.web.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import dev.uedercardoso.mbtc.web.services.VisualRecognitionService;

@RestController
@RequestMapping("/visual-recognition")
public class VisualRecognitionController {

	@Autowired
	VisualRecognitionService visualRecognitionService;
	
	@PostMapping("/predict")
	public ResponseEntity<String> classifyImage(@RequestBody MultipartFile image) throws Exception {
		try {

			String classPredicted = this.visualRecognitionService.classify(image);
			
			return ResponseEntity.ok(classPredicted);
			
		} catch(Exception e) {
			throw new Exception(e);
			//return ResponseEntity.badRequest().build();
		}
	}
	
}

//mvn spring-boot:run
//http://localhost:8080/visual-recognition/predict
//https://cloud.ibm.com/apidocs/visual-recognition/visual-recognition-v3#classify
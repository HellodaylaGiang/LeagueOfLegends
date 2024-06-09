package com.example.demo.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadService {

    private final ServletContext servletContext;

    public UploadService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public String handSaveUploadFile(MultipartFile file, String targertFolder) {
        String name = "";

        if (file.isEmpty()) {
            return "";
        }
        try {
            byte[] bytes = file.getBytes();
            File dir = new File(servletContext.getRealPath("/resources/client") + File.separator + targertFolder);
            if (!dir.exists())
                dir.mkdirs();
            // Create the file on server
            name = System.currentTimeMillis() + "-" + file.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator + name);
            BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (Exception e) {
            // TODO: handle exception
        }
        return name;
    }
}

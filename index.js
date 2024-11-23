const express = require('express');
const multer = require('multer');
const fs = require('fs');
const path = require('path');
const docxConverter = require('docx-pdf');

const app = express();
const upload = multer({ dest: 'uploads/' }); // Temporary upload directory

// Serve static files for frontend (e.g., CSS, JS, images)
app.use(express.static('public'));

// Serve the uploads folder to make converted PDFs accessible for download
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Handle file upload and conversion
app.post('/convert', upload.single('file'), async (req, res) => {
    if (!req.file) {
        return res.status(400).send('Please specify input file');
    }

    const inputFile = req.file.path; // Path to the uploaded DOCX file
    const outputFile = `uploads/${req.file.filename}.pdf`; // Output PDF path

    console.log('Starting DOCX to PDF conversion...');

    try {
        // Convert DOCX to PDF
        await new Promise((resolve, reject) => {
            docxConverter(inputFile, outputFile, (err) => {
                if (err) {
                    console.error('Error during conversion:', err);
                    reject(err);
                } else {
                    console.log(`Conversion successful, file saved at: ${outputFile}`);
                    resolve();
                }
            });
        });

        // Verify if the converted file exists
        if (!fs.existsSync(outputFile)) {
            console.error('Converted file not found:', outputFile);
            return res.status(500).send('File conversion failed.');
        }

        // Extract file name and size (in KB)
        const fileName = req.file.originalname;
        const fileSizeKb = (req.file.size / 1024).toFixed(2); // Convert bytes to KB

        // Respond with metadata and the file download URL
        res.json({
            fileName,
            fileSizeKb,
            downloadUrl: `/uploads/${req.file.filename}.pdf`,
        });
    } catch (err) {
        console.error('Error during processing:', err);
        return res.status(500).send('Error during processing.');
    }
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

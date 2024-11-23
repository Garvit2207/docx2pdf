
# DOCX to PDF Converter

This project provides a simple web application that converts `.docx` files to `.pdf`, with metadata extraction and insertion. The application allows users to upload `.docx` files, convert them into `.pdf` format, and download the resulting file with metadata such as filename and file size.

## Installation and Setup

### Step 1: Clone the Repository

```bash
git clone <repository-url>
cd docx-to-pdf-converter
```

### Step 2: Install Dependencies

```bash
npm install
```

### Step 3: Run the Application

Start the server:

```bash
node index.js
```

The server will run on [http://localhost:4000](http://localhost:4000) by default.

## Usage

1. Open your browser and navigate to [http://localhost:4000](http://localhost:4000).
2. Use the form to upload a `.docx` file.
3. Click the "Convert to PDF" button.
4. Download the generated PDF with metadata.

## Technologies Used

### Backend:
- **Express**: For creating the server.
- **Multer**: For handling file uploads.
- **docx-pdf**: For converting `.docx` to `.pdf`.
- **pdf-lib**: For adding metadata to PDFs.
- **Node.js**: For server-side JavaScript runtime.

### Frontend:
- **HTML/CSS**: For a clean and responsive user interface.
- **JavaScript**: For handling form submissions and interactions.

## Endpoints

### POST /convert
- **Description**: Handles the file upload, converts it to PDF, adds metadata, and returns the converted file for download.
- **Request**: `multipart/form-data` with a `.docx` file.
- **Response**: Initiates a download for the generated PDF.

### Notes
- **Uploads Folder**: Temporary files are stored in the `uploads/` directory during the conversion process. These files are automatically cleaned up after the download.
- **File Size and Metadata**: Metadata includes the original filename and size of the uploaded file.
- **Static Files**: The `public/` directory serves the frontend interface.

## Example Metadata

After conversion, the following metadata is added to the PDF:
- **Title**: "Converted DOCX to PDF"
- **Keywords**: `["filename.docx", "12345"]` (filename and file size in bytes).

## Future Enhancements

- Add support for bulk file uploads.
- Enhance the frontend for better user experience.
- Add error tracking and user-friendly messages.

Contributions are welcome! Feel free to fork the repository and submit a pull request.

Happy coding! 🚀

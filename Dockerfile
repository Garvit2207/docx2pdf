# Step 1: Use an official Node.js runtime as a base image
FROM node:18

# Step 2: Install system dependencies for PhantomJS and OpenSSL
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libfontconfig1 \
    libx11-dev \
    libxext-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libgif-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Step 3: Set the working directory
WORKDIR /usr/src/app

# Step 4: Copy package.json and package-lock.json
COPY package*.json ./

# Step 5: Install project dependencies
RUN npm install

# Step 6: Copy the entire application code
COPY . .

# Step 7: Create the uploads directory
RUN mkdir -p uploads

# Step 8: Expose the application port
EXPOSE 5000

# Step 9: Start the application
CMD ["npm", "start"]

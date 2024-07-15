FROM tensorflow/tensorflow:latest-gpu

# Install TensorRT
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository universe \
    && apt-g    et update && apt-get install -y \
    libnvinfer7 libnvonnxparsers7 libnvparsers7 libnvinfer-plugin7 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install CUDA
RUN apt-get update && apt-get install -y \
    cuda \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:/usr/local/tensorrt/lib
ENV PATH /usr/local/cuda/bin:${PATH}

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]

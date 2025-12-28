# Taxi Fare Prediction with TensorFlow 2

This project is a complete regression pipeline predicting Chicago taxi fares using the BigQuery public dataset. It demonstrates production-ready MLOps workflows on Google Cloud.

## Technical Highlights

* **Model Architecture:** Implemented using three different Keras APIs (Sequential, Functional, and Subclassing) to show versatility.
* **Preprocessing:** Includes `layers.Normalization` directly in the model to handle raw data and prevent training-serving skew.
* **Optimization:** Used MSE loss to penalize outliers. Training includes Early Stopping and a fine-tuned learning rate.
* **Cloud Infrastructure:** Data queried from BigQuery (100k samples) and the final model is uploaded on Vertex AI Model Registry.

## Results

The model achieved a Mean Absolute Error (MAE) of ~$0.30 on 100,000 samples, showing stable convergence and high precision.

## Project Structure

* `main.ipynb`: Core notebook with data extraction, model architectures, and training.
* `requirements.txt`: List of dependencies.
* `setup_env.bat`: Script to set up the environment and Jupyter kernel.
* `upload_model.bat`: Script to create the GCS bucket and upload the model artifact.
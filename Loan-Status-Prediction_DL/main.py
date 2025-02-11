# Import vital libraries
from fastapi import FastAPI
from pydantic import BaseModel, Field
import uvicorn
import numpy as np
import joblib 
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.models import load_model  

# Initialize fastpi
app = FastAPI(title='Loan Prediction')

# Define input schema
class input_params(BaseModel):
    age: int = Field(..., gt=0, lt=101)
    marital_status: str = Field(..., pattern="^(single|married)$")
    income: int = Field(..., gt=0 )
    credit_score: int = Field(..., gt=0)

# Load pre-trained model/standard-scalar
model = keras.models.load_model('Loan_hub.keras')
scalar1 = joblib.load('scalar.job')



# Define api endpoint
@app.post("/predict")
async def make_predictions(data:input_params):
    # encode categorical values
    marital_status_map = {"single": 0, "married": 1}
    mapped_status = marital_status_map.get(data.marital_status)
    # convert to array
    params = np.array([[
        data.age,
        mapped_status,
        data.income,
        data.credit_score
    ]])
    # scale input values
    scaled_params = scalar1.transform(params)
    # predict the model
    prediction = model.predict(scaled_params)
    return{'The model predicted': prediction.item()}


# Activate the server
if __name__ == "__main__":
    uvicorn.run(app, host='127.0.0.1', port=8002)
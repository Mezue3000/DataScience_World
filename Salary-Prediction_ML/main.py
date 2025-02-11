# import vital libraries
from fastapi import FastAPI
from pydantic import BaseModel, Field
import uvicorn
import joblib
from joblib import load
import numpy as np
import pandas as pd
import xgboost as xgb


app = FastAPI(title='Salary Prediction Api')

# define input schemas
class inputData(BaseModel):
    code_no:int 
    YearsExperience:int

# load the pre-trained model/scalar
trained_model = joblib.load('salary.joblib')
scalar2 = joblib.load('scala.jobb')

# define api endpoint    
@app.post("/predict")
def predict_salary(data:inputData):
#  convert to numpy array   
    params = np.array([[
        data.code_no,
        data.YearsExperience
    ]])

#  scale the input datas   
    scaled_params = scalar2.transform(params)
    # Convert to DMatrix (required for XGBoost)
    dmatrix_params = xgb.DMatrix(scaled_params)
#  make predictions   
    prediction = trained_model.predict(dmatrix_params)
    return{'model predicted' : (prediction.item())}

# activate the server
if __name__ == '__main__':
    uvicorn.run("main:app", host="127.0.0.1", port=9005, reload=True)
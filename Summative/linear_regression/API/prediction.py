from fastapi import FastAPI
from pydantic import BaseModel, Field
from joblib import load
from fastapi.middleware.cors import CORSMiddleware
import numpy as np

# 🔹 Load saved model and scaler
model = load("best_model.joblib")
scaler = load("scaler.joblib")

# 🔹 Create FastAPI app
app = FastAPI(title="School Completion Predictor")

# 🔹 Add CORS (allows mobile/web clients to access this API)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # You can restrict this to your Flutter app URL in prod
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 🔹 Define input schema with validation
class InputData(BaseModel):
    age: float = Field(..., ge=10, le=25, description="Age of the individual (10–25)")
    sex: int = Field(..., ge=0, le=1, description="0 = Male, 1 = Female")
    urban: int = Field(..., ge=0, le=1, description="0 = Rural, 1 = Urban")
    region: int = Field(..., ge=0, le=9, description="Encoded region index (0–9)")
    wealth: int = Field(..., ge=0, le=4, description="Wealth index (0 = poorest, 4 = richest)")

# 🔹 Prediction route
@app.post("/predict")
def predict(data: InputData):
    # Create feature array
    X = np.array([[data.age, data.sex, data.urban, data.region, data.wealth]])

    # Standardize input
    X_scaled = scaler.transform(X)

    # Predict
    # Make prediction
    prediction = model.predict(X_scaled)[0]

    # Clip to valid probability range
    clipped = max(0.0, min(1.0, prediction))

    # Return result
    return {
        "completion_probability": round(float(clipped), 4)
    }


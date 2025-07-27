# linear_regression_model
* Hosted API (Swagger): [https://school-completion-prediction-lwfu.onrender.com/docs](https://school-completion-prediction-lwfu.onrender.com/docs)
* Video Demo (5 mins): [https://www.youtube.com/watch?v=29a8fJT36eU](https://www.youtube.com/watch?v=29a8fJT36eU)
# Predicting Secondary School Completion

## Mission

**To investigate how economic and spatial hierarchies shape secondary school completion among girls in African countries and exposing how regional underdevelopment, rural disadvantage, and structural poverty persist as entrenched barriers to educational justice.**

This project applies a data-driven approach to examine which factors most strongly predict whether a young person, particularly girls, completes secondary education. While national education access has improved in many African contexts, we focus on those **still left behind** surfacing the **structural inequalities** hidden beneath aggregate progress.

---

## Why Zimbabwe (2014 MICS) Was Chosen

We selected the **Zimbabwe Multiple Indicator Cluster Survey (MICS) 2014**, produced by **UNICEF**, for these reasons:

* **Nationally representative**, with high-quality education indicators
* Includes variables aligned with our mission:

  * `windex5`: **Wealth index** (structural poverty)
  * `HH6`: **Urban/Rural** residence (spatial inequality)
  * `HH7`: **Subnational region** (regional opportunity gaps)
  * `HL7`: **Age**
  * `HL4`: **Sex**
* Supports **regional analysis** with statistically weighted responses
* Uses international standards, enabling broader African contextualization

> **Note:** Due to how the data is structured, nearly all filtered records with valid education data are **female**. Rather than a limitation, this frames our model as a **focused investigation of educational inequality for girls** ,a group historically disadvantaged across sub-Saharan Africa.

---

##  Modeling Summary

We built a classification model to predict whether a girl completed secondary school (`ED4A`). The target is binary:

* `1` = Completed secondary education
* `0` = Did not complete secondary

### Features Used:

* `HL7` — Age
* `HL4` — Sex (0 = Male, 1 = Female)
* `HH6` — Urban/Rural (0 = Rural, 1 = Urban)
* `HH7` — Region (Encoded 0–9)
* `windex5` — Wealth index (0 = Poorest to 4 = Richest)

---

## Model Comparison

| Model               | Mean Squared Error (MSE) |
| ------------------- | ------------------------ |
|   Linear Regression | **0.1622** (Best)        |
| Decision Tree       | 0.2546                   |
| Random Forest       | 0.1870                   |

We selected **Linear Regression** for final deployment because:

* It performed best on the test set
* It fits the structure of the data (broad, additive predictors)
* It’s transparent and interpretable for social policy applications

---

## API Deployment

A FastAPI service exposes the trained model as a RESTful API for integration with mobile apps or external systems.

* Frameworks: `FastAPI`, `Pydantic`, `Uvicorn`, `joblib`
* POST endpoint: `/predict`
* Returns: probability of school completion (range: 0–1)
* Validates data types and value ranges
* **Public Swagger UI**:
  [https://school-completion-prediction-lwfu.onrender.com/docs](https://school-completion-prediction-lwfu.onrender.com/docs)

> **Note**: Render free-tier servers sleep after 15 minutes of inactivity. Wake-up may take \~30–60 seconds.

---

## Flutter Mobile App

The Flutter app connects to the API and allows users to:

* Input values for age, sex, region, residence type, and wealth
* Submit the data to the API
* Receive and display the predicted completion probability

Includes:

* Stylish prediction form
* Real-time error handling
* Themed loading screen to explain delays.

---

## Testing Notes

* Inputs are validated via both FastAPI and Flutter UI
* Only female data was used to train the model → predictions for `sex=0` (male) are extrapolated and may be less reliable
* Prediction output is a probability between 0 and 1 — optionally displayed as a percentage

---
---

## How to Run the Mobile App

### Requirements

* Flutter SDK (version ≥ 3.x)
* Android Studio or VS Code with Flutter/Dart plugins
* An Android emulator or a physical Android device (for testing)
* Internet access (to reach the deployed API)

---

### 1. Clone the repository

```bash
git clone https://github.com/your-username/linear_regression_model.git
cd linear_regression_model/summative/FlutterApp
```

---

### ⚙2. Install dependencies

Make sure you’re inside the `FlutterApp/` folder, then run:

```bash
flutter pub get
```

---

### 3. Run the app on an emulator or device

Start an Android emulator or connect your device, then run:

```bash
flutter run
```

---

### 4. App behavior

* The app sends data (age, sex, region, etc.) to the **FastAPI model** hosted at:

  > `https://school-completion-prediction-lwfu.onrender.com/predict`

* You’ll see a themed **loading screen** while the server wakes up (Render free-tier).

* After prediction, a result page displays the **completion probability**.

* Errors or offline status will be handled and displayed clearly.

---

### Notes

* If the app seems unresponsive after clicking “Predict,” it’s likely waiting for the Render API to wake up. Give it 30–60 seconds.
* Be sure your internet connection is stable to allow the app to reach the external API.

---

## Repository Structure

```
linear_regression_model/
└── summative/
    ├── linear_regression/
    │   ├── Summative.ipynb            ← Modeling notebook
    │   ├── best_model.joblib          ← Final model
    │   ├── scaler.joblib              ← Standardizer
    ├── API/
    │   ├── prediction.py              ← FastAPI app
    │   ├── requirements.txt
    ├── prediction_app/
    │   ├── lib/
    │   │   ├── main.dart              ← App entry
    │   │   ├── pages/
    │   │   ├── widgets/

from flask import Flask, request, jsonify
from tensorflow.keras.models import load_model
import numpy as np

from tensorflow.keras.losses import SparseCategoricalCrossentropy

def load_custom_model(model_path):
    return load_model(model_path, compile=False, custom_objects={'SparseCategoricalCrossentropy': SparseCategoricalCrossentropy})

app = Flask(__name__)
model = load_custom_model('my_model.h5')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()
        if 'index' not in data:
            raise ValueError("Invalid JSON format. 'index' field is missing.")

        X = np.zeros((1, 59))
        for i in range(len(data)):
            X[0, i] = data[i]['index']

        prediction = model.predict(X)
        predicted_class = np.argmax(prediction)

        personality_types = ['ESTJ', 'ENTJ', 'ESFJ', 'ENFJ', 'ISTJ', 'ISFJ', 'INTJ', 'INFJ', 'ESTP', 'ESFP', 'ENTP', 'ENFP', 'ISTP', 'ISFP', 'INTP', 'INFP']
        result = {"personality_type": personality_types[predicted_class]}
        return jsonify(result)
    except ValueError as ve:
        return jsonify({"error": str(ve)}), 400  # Bad Request for invalid data
    except Exception as e:
        print(f"An error occurred: {e}")
        return jsonify({"error": "Internal Server Error"}), 500

if __name__ == '__main__':
    app.run(debug=True)

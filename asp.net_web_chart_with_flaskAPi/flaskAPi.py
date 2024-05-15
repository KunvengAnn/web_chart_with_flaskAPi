from flask import Flask
import requests

app = Flask(__name__)

def get_weather_data(city="Phnom Penh"):
    try:
        api_key = "67ddd13dc6d82ac3921a85d5ab39ecc2"
        url = f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&units=metric"
        response = requests.get(url)
        response.raise_for_status()  # Raise exception for HTTP errors
        return response.json()
    except requests.exceptions.RequestException as e:
        return {"error": f"Error fetching weather data: {e}"}

@app.route('/weather')
def read_data():
    weather_data = get_weather_data()
    if "error" in weather_data:
        return {'weather_data':weather_data}
    
    temperature = weather_data.get("main", {}).get("temp")
    humidity = weather_data.get("main", {}).get("humidity")
    
    if temperature is not None and humidity is not None:
        return {"temperature": temperature, "humidity": humidity}
    else:
        return {"error": "Weather data not available"}

if __name__ == '__main__':
    app.run(debug=True)

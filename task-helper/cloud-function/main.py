import functions_framework
import google.generativeai as genai
import json
import re

# Configure seu Gemini
genai.configure(api_key="AIzaSyDmmLlJnE5FYsI4pFEPk5RE9bitbq7es30")
model = genai.GenerativeModel('models/gemini-2.5-flash')

@functions_framework.http
def handle_request(request):
    # Trata o CORS para permitir que o site acesse a Function
    if request.method == 'OPTIONS':
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Max-Age': '3600'
        }
        return ('', 204, headers)

    headers = {'Access-Control-Allow-Origin': '*'}
    
    request_json = request.get_json(silent=True)
    user_text = request_json.get("text", "")

    if not user_text:
        return (json.dumps({"error": "No text provided"}), 400, headers)

    prompt = f"""
    Extraia as tarefas do seguinte texto e retorne APENAS um JSON válido.
    Texto: {user_text}
    Formato: {{"tasks": [{{"title": "título", "description": "descrição"}}]}}
    """

    try:
        response = model.generate_content(prompt)
        # Limpa o markdown da resposta se houver
        json_match = re.search(r'\{.*\}', response.text, re.DOTALL)
        if json_match:
            return (json_match.group(0), 200, headers)
        return (response.text, 200, headers)
    except Exception as e:
        return (json.dumps({"error": str(e)}), 500, headers)
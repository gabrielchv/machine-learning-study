import functions_framework
import google.generativeai as genai
import json
import re
import base64

genai.configure(api_key="GEMINI_API_KEY")
model = genai.GenerativeModel('gemini-2.0-flash') # Versão estável multimodal

@functions_framework.http
def handle_request(request):
    # CORS
    if request.method == 'OPTIONS':
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Max-Age': '3600'
        }
        return ('', 204, headers)

    headers = {'Access-Control-Allow-Origin': '*'}
    prompt = """
    Extraia as tarefas do seguinte conteúdo e retorne APENAS um JSON válido.
    Não inclua descrições, retorne apenas os títulos das tarefas.
    Formato: {"tasks": [{"title": "título da tarefa"}]}
    """

    try:
        # Verifica se é áudio (multipart/form-data)
        if 'audio' in request.files:
            audio_file = request.files['audio']
            audio_data = audio_file.read()
            
            # Gemini processa áudio via dicionário de bytes
            response = model.generate_content([
                prompt,
                {"mime_type": "audio/webm", "data": audio_data}
            ])
        
        # Caso contrário, trata como JSON de texto
        else:
            request_json = request.get_json(silent=True)
            user_text = request_json.get("text", "")
            response = model.generate_content(f"{prompt} Texto: {user_text}")

        # Limpeza do JSON
        json_match = re.search(r'\{.*\}', response.text, re.DOTALL)
        result = json_match.group(0) if json_match else response.text
        return (result, 200, headers)

    except Exception as e:
        return (json.dumps({"error": str(e)}), 500, headers)
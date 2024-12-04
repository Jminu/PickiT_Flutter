import requests
from bs4 import BeautifulSoup
import openai
import re
from dotenv import load_dotenv
import os

# .env 파일 로드
load_dotenv()

# 환경 변수에서 API 키 읽기
openai.api_key = os.getenv("OPENAI_API_KEY")


# 기사 내용 가져오기
def getArticleContent(url):
    response = requests.get(url, timeout=10)
    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')

        # article태그 탐색
        paragraphs = soup.find_all('article')
        if paragraphs:
            content = " ".join([p.get_text() for p in paragraphs])
        else:  # article태크 없으면 p태그 기반 탐색
            paragraphs = soup.find_all('p')
            filteredParagraphs = [
                p for p in paragraphs if not p.get('class') in [['ad'], ['footer'], ['comment']]
            ]
            content = " ".join([p.get_text() for p in filteredParagraphs])

        return clean_text(content)
    else:
        print("Failed to fetch Article. Status Code:", response.status_code)
        return None


# 텍스트 정리
def clean_text(text):
    if not text:
        return ""
    text = re.sub(r'\s+', ' ', text)  # 공백 정리
    text = re.sub(r'[^\w\s.,]', '', text)  # 특수문자 제거
    return text.strip()


# ChatGPT를 사용하여 요약
def summarize_with_chatgpt(article, title, max_tokens=500):
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",  # 또는 gpt-4
        messages=[
            {"role": "system",
             "content": "당신은 기사를 요약하는 유능한 조수입니다. 당신의 임무를 제목과 관련된 핵심 내용을 추려 요약하는 것입니다."},
            {"role": "user", "content": f"다음은 기사 제목입니다.: {title}\n"
             f"다음은 기사 본문입니다: \n\n{article}"
             "위 본문에서 제목과 직접적으로 관련된 핵심 내용만 한국어로 3줄에서 5줄 사이로 요약해 주세요. 제목과 관련 없는 내용은 포함하지 마세요."}
        ],
        max_tokens=max_tokens,
        temperature=0.7
    )
    return response['choices'][0]['message']['content']

import requests
from bs4 import BeautifulSoup
import openai
import re
import os

# OpenAI API 키 설정

# 기사 내용 가져오기
def getArticleContent(url):
    response = requests.get(url, timeout=10)
    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        paragraphs = soup.find_all('p')
        content = " ".join([p.get_text() for p in paragraphs])
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
def summarize_with_chatgpt(article, max_tokens=500):
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",  # 또는 gpt-4
        messages=[
            {"role": "system", "content": "당신은 기사를 요약하는 유능한 조수입니다."},
            {"role": "user", "content": f"다음 기사를 한국어로 요약해 주세요:\n\n{article}"}
        ],
        max_tokens=max_tokens,
        temperature=0.7
    )
    return response['choices'][0]['message']['content']


# 실행
if __name__ == "__main__":
    # URL 예시 (요약하려는 기사 URL)
    url = "https://n.news.naver.com/mnews/article/001/0015067378?rc=N&ntype=RANKING"

    # 기사 내용 가져오기
    article = getArticleContent(url)

    if article:
        print("원문 길이 (문자 수):", len(article))
        print("\n=== 원문 ===\n", article)

        # ChatGPT를 사용하여 요약
        summary = summarize_with_chatgpt(article, max_tokens=500)
        if summary:
            print("\n=== 요약 ===\n", summary)
        else:
            print("요약 중 오류가 발생했습니다.")
    else:
        print("기사를 가져오지 못했습니다.")

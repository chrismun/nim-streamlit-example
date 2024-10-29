import streamlit as st
from langchain_nvidia_ai_endpoints import ChatNVIDIA
from langchain_core.output_parsers import StrOutputParser

MODEL = "mistral-nemo-12b-instruct"
# CHAT_URL = "http://localhost:8080/v1/chat/completions"
CHAT_URL = "http://localhost:8080/v1/"

st.title("NVIDIA NIM on Open OnDemand")

prompt = st.chat_input("Ask anything!")
model = ChatNVIDIA(
    model=MODEL,
    base_url=CHAT_URL,
    temperature=0.5,
    max_tokens=100,
)

if prompt:
    st.chat_message("user").write(prompt)
    
    chain = model | StrOutputParser()
    
    with st.chat_message("assistant"):
        message_placeholder = st.empty()
        full_response = ""

        for chunk in chain.stream(prompt):
            full_response += chunk
            message_placeholder.markdown(full_response + "▌")

        message_placeholder.markdown(full_response)

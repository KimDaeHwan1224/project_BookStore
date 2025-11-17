// 더보기 버튼
document.addEventListener('DOMContentLoaded', function() {
  const loadMoreBtn = document.getElementById('loadMoreBtn');
  const additionalProducts = document.getElementById('additionalProducts');
  if(!loadMoreBtn || !additionalProducts) return;
  let isExpanded = false;

  loadMoreBtn.addEventListener('click', function() {
    if (!isExpanded) {
      additionalProducts.classList.remove('hidden');
      loadMoreBtn.textContent = '접기';
      isExpanded = true;
      additionalProducts.scrollIntoView({ behavior: 'smooth', block: 'start' });
    } else {
      additionalProducts.classList.add('hidden');
      loadMoreBtn.textContent = '더보기';
      isExpanded = false;
    }
  });
});

// 책 속 한 줄: 좌우 스크롤
(function(){
  const track = document.getElementById('quotesTrack');
  if(!track) return;
  const prev = document.getElementById('quotesPrev');
  const next = document.getElementById('quotesNext');

  const cardWidth = () => {
    const first = track.querySelector('.q-card');
    if(!first) return 320;
    return first.getBoundingClientRect().width + 16;
  };

  prev.addEventListener('click', ()=> track.scrollBy({left:-cardWidth(), behavior:'smooth'}));
  next.addEventListener('click', ()=> track.scrollBy({left: cardWidth(), behavior:'smooth'}));
})();

// FAQ 토글
(function(){
  const items = document.querySelectorAll('.faq-item');
  if(!items.length) return;
  items.forEach(item => {
    const q = item.querySelector('.faq-question');
    const a = item.querySelector('.faq-answer');
    const icon = item.querySelector('.faq-icon');
    if(a){
      a.style.maxHeight = '0px';
      a.style.overflow = 'hidden';
      a.style.boxSizing = 'border-box';
      a.style.willChange = 'max-height';
      a.style.transition = 'max-height 300ms cubic-bezier(.2,.6,.2,1), padding 300ms cubic-bezier(.2,.6,.2,1)';
      a.style.paddingTop = '0px';
      a.style.paddingBottom = '0px';
    }
    q.addEventListener('click', () => {
      const open = a && a.style.maxHeight !== '0px';
      if(open){
        a.style.maxHeight = '0px';
        a.style.paddingTop = '0px';
        a.style.paddingBottom = '0px';
        if(icon){ icon.style.transform = 'rotate(0deg)'; }
        item.classList.remove('active');
      } else {
        a.style.maxHeight = (a.scrollHeight + 24) + 'px';
        a.style.paddingTop = '8px';
        a.style.paddingBottom = '12px';
        if(icon){ icon.style.transform = 'rotate(180deg)'; }
        item.classList.add('active');
      }
    });
  });
})();
//chat
// === 챗봇 열기/닫기 ===
document.getElementById("chatbotBtn").addEventListener("click", function() {
  document.getElementById("chatbotModal").style.display = "block";
});

document.getElementById("chatbotClose").addEventListener("click", function() {
  document.getElementById("chatbotModal").style.display = "none";
});

// === 메시지 출력 함수 (더보기 + 접기 기능 포함) ===
function displayMessage(text, sender = "bot") {
    const box = document.getElementById("chatMessages");

    const wrapper = document.createElement("div");
    wrapper.className = sender === "user" ? "chat-msg user" : "chat-msg bot";

    // 봇일 때만 아바타
    if (sender === "bot") {
        const avatar = document.createElement("img");
        avatar.className = "chat-avatar";
        avatar.src = "/img/bot.png"; 
        wrapper.appendChild(avatar);
    }

    const bubble = document.createElement("div");
    bubble.className = "msg-bubble";
    bubble.innerHTML = text;
    wrapper.appendChild(bubble);

    box.appendChild(wrapper);

    // 자동 접기
//    setTimeout(() => {
//        if (bubble.scrollHeight > 120) {
//            collapseBubble(bubble);
//        }
//		
//    }, 10);

    box.scrollTop = box.scrollHeight;
}


// -------------------------------
// 말풍선 접기 상태로 만들기
// -------------------------------
function collapseBubble(bubble) {

    // class 추가 (중요!!)
    bubble.classList.add("collapsed");

    bubble.dataset.originalHeight = bubble.scrollHeight;

    bubble.style.maxHeight = "140px";
    bubble.style.overflow = "hidden";
    bubble.style.paddingBottom = "32px";

    bubble.style.maskImage =
        "linear-gradient(to bottom, black 70%, transparent 100%)";

    addToggleButton(bubble, "더보기", expandBubble);
}

function expandBubble(bubble) {

    // class 제거
    bubble.classList.remove("collapsed");

    bubble.style.maxHeight = "none";
    bubble.style.overflow = "visible";
    bubble.style.maskImage = "none";

    replaceToggleButton(bubble, "접기", collapseBubble);
}

function addToggleButton(bubble, label, action) {
    const oldBtn = bubble.querySelector(".see-more-btn");
    if (oldBtn) oldBtn.remove();

    const btn = document.createElement("button");
    btn.className = "see-more-btn";
    btn.textContent = label;
    btn.type = "button";

    btn.onclick = (e) => {
        e.stopPropagation();  // 혹시 버블링 문제 방지
        action(bubble);
    };

    bubble.appendChild(btn);
}

function replaceToggleButton(bubble, label, action) {
    const oldBtn = bubble.querySelector(".see-more-btn");
    if (oldBtn) oldBtn.remove();
    addToggleButton(bubble, label, action);
}



// -------------------------------
// 말풍선 확장 (전체 보기)
// -------------------------------
function expandBubble(bubble) {
    bubble.style.maxHeight = "none";
    bubble.style.overflow = "visible";
    bubble.style.maskImage = "none";
    bubble.style.paddingBottom = "32px";

    // 버튼 교체: 접기 버튼으로
    replaceToggleButton(bubble, "접기", collapseBubble);
}

document.querySelector(".chat-send-btn").addEventListener("click", () => {
    sendUserMessage(document.getElementById("chatInput").value);
});

//function displayMessage(text, sender = "bot") {
//    const box = document.getElementById("chatMessages");
//    const div = document.createElement("div");
//
//    if (sender === "user") {
//        div.style.textAlign = "right";
//        div.innerHTML = `
//            <div style="
//                display:inline-block;
//                background:#DCF8C6;
//                padding:8px 12px;
//                border-radius:10px;
//                margin:5px 0;
//                max-width:70%;
//            ">${text}</div>`;
//    } else {
//        div.style.textAlign = "left";
//        div.innerHTML = `
//            <div style="
//                display:inline-block;
//                background:#F1F0F0;
//                padding:8px 12px;
//                border-radius:10px;
//                margin:5px 0;
//                max-width:70%;
//            ">${text}</div>`;
//    }
//
//    box.appendChild(div);
//    box.scrollTop = box.scrollHeight;
//}

//// === 메시지 출력 함수 ===
//function displayMessage(text, sender = "bot") {
//    const box = document.getElementById("chatMessages");
//    const div = document.createElement("div");
//
//    // user / bot 클래스 적용
//    div.className = sender === "user" ? "chat-msg user" : "chat-msg bot";
//
//    // 공통 말풍선
//    div.innerHTML = `<div class="msg-bubble">${text}</div>`;
//
//    box.appendChild(div);
//    box.scrollTop = box.scrollHeight;
//}

// === Gemini API 호출 + 출력 ===
function sendUserMessage(message) {
    if (!message.trim()) return;

    displayMessage(message, "user");
    document.getElementById("chatInput").value = "";

    showTyping();   // 🔥 여기서 로딩말풍선 시작!

    fetch('/api/gemini', {
        method: 'POST',
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify({message: message})
    })
    .then(resp => resp.json())
    .then(data => {
        hideTyping(); // 🔥 답변 오면 제거
        const botText = data.contents[0].parts[0].text;
        displayMessage(botText, "bot");
    })
    .catch(err => {
        hideTyping();
        displayMessage("“지금 GPT가 잠시 바쁨! 조금 뒤 다시 시도해줘 😊”", "bot");
    });
}

// === 엔터로 전송 ===
document.getElementById("chatInput").addEventListener("keydown", function(e){
    if (e.key === "Enter") {
        sendUserMessage(this.value);
    }
});

function showTyping() {
    const box = document.getElementById("chatMessages");

    // 이미 존재하면 중복 생성 방지
    if (document.getElementById("typing-indicator")) return;

    const wrapper = document.createElement("div");
    wrapper.className = "chat-msg bot";
    wrapper.id = "typing-indicator";

    wrapper.innerHTML = `
        <div class="msg-bubble typing-animation">
            <span class="dot"></span>
            <span class="dot"></span>
            <span class="dot"></span>
        </div>
    `;

    box.appendChild(wrapper);
    box.scrollTop = box.scrollHeight;
}

function hideTyping() {
    const typing = document.getElementById("typing-indicator");
    if (typing) typing.remove();
}

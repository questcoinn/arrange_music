document.querySelectorAll("input.reco-btn").forEach(x => {
    x.addEventListener("click", (e) => {
        // validwritercheck.js
        getReader().then((uid) => {
            const container = e.target.parentElement.parentElement;
    
            const artist = container.querySelector("span.artist").innerHTML;
            const title  = container.querySelector("span.title").innerHTML;
        
            const recoEl = container.querySelector("strong.reco");
        
            if(uid === null || uid === "null")
                alert("로그인을 해주세요.");
            else {
                checkReco(uid, artist, title, recoEl);
            }
        });
        
    });
});

const checkReco = async (uid, artist, title, el) => {
    const _response = await thumbsup(uid, artist, title);
    const response = _response.trim()
    
    if(response === "failed_con") {
        alert("서버에 문제가 있습니다.");

    } else if(response === "failed_already") {
        alert("이미 추천했습니다.");

    } else if(response === "failed_sql") {
        alert("서버에 문제가 있습니다.");

    } else if(response === "successed") {
        const val = parseInt(el.innerHTML);
        el.innerHTML = val + 1;

    } else {
        alert("알 수 없는 오류");
    }
}

document.querySelectorAll("input.heard-btn").forEach(x => {
    x.addEventListener("click", (e) => {
        // validwritercheck.js
        getReader().then((uid) => {
            const container = e.target.parentElement.parentElement;
    
            const artist = container.querySelector("span.artist").innerHTML;
            const title  = container.querySelector("span.title").innerHTML;

            const hearEl = container.querySelector("input.heard-btn");
        
            if(uid === null || uid === "null")
                alert("로그인을 해주세요.");
            else {
                checkHeard(uid, artist, title, hearEl);
            }
        });
    });
});

const checkHeard = async (uid, artist, title, el) => {
    const _response = await heardthis(uid, artist, title);
    const response = _response.trim()
    
    if(response === "failed_con") {
        alert("서버에 문제가 있습니다.");

    } else if(response === "failed_already") {
        alert("이미 들었습니다.");

    } else if(response === "failed_sql") {
        alert("서버에 문제가 있습니다.");

    } else if(response === "successed") {
        el.style.background = "#24cdff";

    } else {
        alert("알 수 없는 오류");
    }
}
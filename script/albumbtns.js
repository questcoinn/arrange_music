document.querySelectorAll("input.reco-btn").forEach(x => {
    x.addEventListener("click", (e) => {
        const container = e.target.parentElement.parentElement;
    
        const uid    = document.querySelector("div#login-box").getAttribute("uid");
        const artist = container.querySelector("span.artist").innerHTML;
        const title  = container.querySelector("span.title").innerHTML;
    
        const recoEl = container.querySelector("strong.reco");
    
        check(uid, artist, title, recoEl);
    });
});

const check = async (uid, artist, title, el) => {
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
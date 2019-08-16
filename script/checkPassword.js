document.querySelector("input#upwd-cfg-in").addEventListener("change", (e) => {
    const pwd = document.querySelector("input#upwd-in").value;
    const info = document.querySelector("div#upwd-cfg p.info");

    if(e.target.value !== pwd) {
        info.innerHTML = "비밀번호를 다시 확인해주세요.";
    } else {
        info.innerHTML = "";
    }
});
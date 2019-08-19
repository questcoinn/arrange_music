document.querySelector("input#login-btn").addEventListener("click", (e) => {
    e.preventDefault();

    const form = document.querySelector("div#login-box form");
    const id   = document.querySelector("input#uid-box").value;
    const pwd  = document.querySelector("input#upwd-box").value;

    if(id === "") {
        alert("아이디를 입력해주세요.");
    } else if(pwd === "") {
        alert("패스워드를 입력해주세요.");
    } else {     
        check(id, pwd, form);
    }
});

const check = async (id, pwd, form) => {
    const _response = await checkId(id, pwd);
    const response = _response.trim()
    
    if(response === "failed_con") {
        alert("서버에 문제가 있습니다.");

    } else if(response === "failed_id") {
        alert("아이디가 존재하지 않습니다.");

    } else if(response === "failed_pwd") {
        alert("비밀번호가 틀립니다.");

    } else if(response === "successed") {
        form.requestSubmit();

    } else {
        alert("알 수 없는 오류");
    }
}
const useId = () => {
    const uid = document.querySelector("input#uid-in").value;
    document.querySelector("div#uid p.info").innerHTML = "";

    document.querySelector("input#submit").uid = uid;
}

document.querySelector("input#check").addEventListener("click", (e) => {
    checkExistingId(document.querySelector("input#uid-in").value);
});

document.querySelector("input#submit").addEventListener("click", (e) => {
    e.preventDefault();

    const uid      = document.querySelector("input#uid-in").value;
    const upwd     = document.querySelector("input#upwd-in").value;
    const upwd_cfg = document.querySelector("input#upwd-cfg-in").value;
    const unick    = document.querySelector("input#unick-in").value;

    const exceptions = {
        "null_id": uid === "",
        "id": e.target.uid === undefined || e.target.uid !== uid,
        "null_pwd": upwd === "",
        "pwd_not_correct": upwd !== upwd_cfg,
        "null_nick": unick === "",
    }

    if(exceptions.null_id) {
        alert("아이디를 입력하세요.");
    } else if(exceptions.id) {
        alert("아이디가 잘못되었거나 중복확인을 하지 않았습니다.\n아이디를 다시 한번 확인하세요.");
    } else if(exceptions.null_pwd) {
        alert("패스워드를 입력하세요.");
    } else if(exceptions.pwd_not_correct) {
        alert("패스워드를 다시 한번 확인하세요.");
    } else if(exceptions.null_nick) {
        alert("닉네임을 입력하세요.");
    } else {
        document.querySelector("form#sign-form").requestSubmit();
    }
});
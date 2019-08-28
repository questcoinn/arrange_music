const invalidList = [ `'`, `"`, "`", " ", "/", "\\" ];

const useId = () => {
    const uid = document.querySelector("input#uid-in").value;
    document.querySelector("div#uid p.info").innerHTML = "";

    document.querySelector("input#submit").uid = uid;
}

// 아이디 중복확인 및 유효성검사
document.querySelector("input#check").addEventListener("click", (e) => {
    const str = document.querySelector("input#uid-in").value;
    const info = document.querySelector("div#uid p.info");

    if(str.split("").some(x => invalidList.includes(x))) {
        info.innerHTML
            = `공백 및 ', &nbsp;", &nbsp;\`, &nbsp;/, &nbsp;\\ 는 아이디에 포함될 수 없습니다.`;

    } else {
        checkExistingId(str);
    }
});

// 비밀번호 확인
document.querySelector("input#upwd-cfg-in").addEventListener("change", (e) => {
    const pwd = document.querySelector("input#upwd-in").value;
    const info = document.querySelector("div#upwd-cfg p.info");

    if(e.target.value !== pwd) {
        info.innerHTML = "비밀번호를 다시 확인해주세요.";
    } else {
        info.innerHTML = "";
    }
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
        "invalid_id_char": uid.split("").some(x => invalidList.includes(x)),
        "null_pwd": upwd === "",
        "pwd_not_correct": upwd !== upwd_cfg,
        "null_nick": unick === "",
    }

    if(exceptions.null_id) {
        alert("아이디를 입력하세요.");

    } else if(exceptions.id) {
        alert("아이디가 잘못되었거나 중복확인을 하지 않았습니다.\n아이디를 다시 한번 확인하세요.");
    
    } else if(exceptions.invalid_id_char) {
        alert("다음 글자는 아이디로 쓸 수 없습니다.\n" + `공백, ',  ",  \`,  /,  \\`);

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
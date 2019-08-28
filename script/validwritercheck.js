const isNull = (uid) => (uid === null || uid === "null") ? true : false;
const isValid = (reader, writer) => (reader === writer) ? true : false;

try {
    document.querySelector("div#write-box input").addEventListener("click", (e) => {
        getReader().then((reader) => {
            if(isNull(reader)) {
                alert("로그인을 해주세요.")
            } else {
                document.querySelector("div#write-box a").click();
            }
        });
    });
} catch {}

try {
    document.querySelector("input#update-fake").addEventListener("click", (e) => {
        getReader().then((reader) => {
            const writer = document.querySelector("strong#writer").innerHTML;
        
            if(isNull(reader)) {
                alert("로그인을 해주세요.")

            } else if(isValid(reader, writer)) {
                document.querySelector("input#update-btn").click();

            } else {
                alert("작성자만 글을 수정할 수 있습니다.")
            }
        });
    });

    document.querySelector("input#delete-fake").addEventListener("click", (e) => {
        getReader().then((reader) => {
            const writer = document.querySelector("strong#writer").innerHTML;

            if(isNull(reader)) {
                alert("로그인을 해주세요.")

            } else if(isValid(reader, writer)) {
                document.querySelector("input#delete-btn").click();

            } else {
                alert("작성자만 글을 삭제할 수 있습니다.")
            }
        });
    });
} catch {}

const getReader = async () => {
    const _response = await checkReader();
    const response = _response.trim()
    
    return response;
}
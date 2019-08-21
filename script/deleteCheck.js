document.querySelector("input#delete-btn").addEventListener("click", (e) => {
    e.preventDefault();

    const check = confirm("정말 삭제하시겠습니까?");

    if(check) {
        document.querySelector("form#delete-form").requestSubmit();
    }
});
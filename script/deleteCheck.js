document.querySelector("input#delete-btn").addEventListener("click", (e) => {
    e.preventDefault();

    const checkD = confirm("정말 삭제하시겠습니까?");

    if(checkD) {
        document.querySelector("form#delete-form").requestSubmit();
    }
});
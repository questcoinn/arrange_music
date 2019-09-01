/*const myImage = document.createElement('img');

const myRequest = new Request('/images/nothing.png');

fetch(myRequest)
.then(response => response.blob())
.then(function(myBlob) {
  var objectURL = URL.createObjectURL(myBlob);
  myImage.src = objectURL;
  URL.revokeObjectURL(myBlob);
});

document.body.appendChild(myImage);*/

/*const type = "image/png";

fetch("imgtobinary.jsp")
    .then((res) => {
        res.text().then((text) => {
            let binary = text.split(" ").map(x => parseInt(x));
            binary = new Uint8Array(binary);
            return new Blob([binary], { type: type });

        }).then((myBlob) => {
            const url = URL.createObjectURL(myBlob);
            const img = document.createElement("img");
            img.src = url;
            document.body.appendChild(img);
            URL.revokeObjectURL(myBlob);
        });
    });*/

const option = {
    type: "image/png",
    file: "nothing.png"
}

const getBlob = async (option) => {
    const response = await fetch(`imgtobinary.jsp?file=${option.file}`);
    
    let binary = await response.text();
    binary = binary.split(" ").map(x => parseInt(x));
    binary = new Uint8Array(binary);

    return new Blob([binary], { type: option.type });
}

getBlob(option).then((myBlob) => {
    const url = URL.createObjectURL(myBlob);
    const img = document.createElement("img");
    img.src = url;
    document.body.appendChild(img);
    URL.revokeObjectURL(myBlob);
});

var list = performance.getEntriesByType("resource");

// For each "resource", display its *Size property values
console.log("= Display Size Data");
for (var i=0; i < list.length; i++) {
console.log("== Resource[" + i + "] - " + list[i].name);
if ("decodedBodySize" in list[i])
    console.log("... decodedBodySize[" + i + "] = " + list[i].decodedBodySize);
else
    console.log("... decodedBodySize[" + i + "] = NOT supported");

if ("encodedBodySize" in list[i])
    console.log("... encodedBodySize[" + i + "] = " + list[i].encodedBodySize);
else
    console.log("... encodedBodySize[" + i + "] = NOT supported");

if ("transferSize" in list[i])
    console.log("... transferSize[" + i + "] = " + list[i].transferSize);
else
    console.log("... transferSize[" + i + "] = NOT supported");
}
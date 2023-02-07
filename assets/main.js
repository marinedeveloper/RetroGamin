const datalist = document.getElementById("dataList");

const search = document.querySelector('#searchList')


search.addEventListener("keyup", function () {
    fetch("api/search/"+search.value)
        .then(response => response.json())
        .then(json => {
            datalist.innerHTML = "";
            for(const title of json) {
                const option = document.createElement("option");
                option.value = title
                datalist.append(option);
                console.log(option);
            }
        })
});

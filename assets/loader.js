console.log('here');
//écouteurs click sur boutons et fetch
let buttonsAdd = document.querySelectorAll('.addButton');
let buttonsDelete = document.querySelectorAll('.deleteButton');


function addElement(event){
        event.preventDefault();
        this.dataset.product;
        let inputQuantity = this.previousElementSibling.value;
        fetch("/cart/"+this.dataset.product+"/add?quantity="+inputQuantity);
        window.location.reload(false);
}

for(const button of buttonsAdd){
        button.addEventListener("click", addElement);
}

function removeElement(event){
        event.preventDefault();
        this.dataset.product;
        let inputQuantity = this.previousElementSibling.value;
        fetch("/cart/"+this.dataset.product+"/remove?quantity="+inputQuantity);
        window.location.reload(false);

}

for(const button of buttonsDelete){
        button.addEventListener("click", removeElement);
}









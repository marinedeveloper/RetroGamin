import { Controller } from '@hotwired/stimulus';

/*
 * This is an example Stimulus controller!
 *
 * Any element with a data-controller="hello" attribute will cause
 * this controller to be executed. The name "hello" comes from the filename:
 * hello_controller.js -> "hello"
 *
 * Delete this file or adapt it for your use!
 */
export default class extends Controller {
    static targets = ['search', 'datalist']

    searchKeyUp() {
       fetch("api/search/"+this.searchTarget.value)
            .then(response => response.json())
            .then(json => {
                this.datalistTarget.innerHTML = "";
                for(const title of json) {
                    const option = document.createElement("option");
                    option.value = title
                    this.datalistTarget.append(option);
                    console.log(option);
                }
            })
    }
}

import noUiSlider from 'nouislider';
import 'nouislider/dist/nouislider.css';


const slider = document.getElementById('slider');
const minView = document.getElementById("minView")
const maxView = document.getElementById("maxView")
const minHidden = document.getElementById("minHidden")
const maxHidden = document.getElementById("maxHidden")

noUiSlider.create(slider, {
    start: [parseInt(minView.textContent)/100, parseInt(maxView.textContent)/100],
    connect: true,
    range: {
        'min': parseInt(minView.textContent)/100,
        'max': parseInt(maxView.textContent)/100
    }
});


function refresh(values) {
    console.log(values)
    minView.textContent=values[0];
    maxView.textContent=values[1];
    minHidden.value=values[0];
    maxHidden.value=values[1];
}

// Binding signature
slider.noUiSlider.on("update", refresh);
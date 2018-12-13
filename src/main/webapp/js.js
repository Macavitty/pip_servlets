
function setError(elem, container, message) {
    let dynMessage = document.createElement('span');
    dynMessage.className = 'invalid_input_message';
    elem.className = 'invalid_input';
    dynMessage.innerHTML = message;
    container.appendChild(dynMessage);
}

function removeError(elem, container) {
    elem.className = '';
    if (container.lastChild.className === 'invalid_input_message')
        container.removeChild(container.lastChild);
}

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('submit_params').addEventListener('click', submit);
});

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById("y_input").addEventListener('change', removeError);
});


function disable_not_numbers() {
    let keys = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", ".", ","];
    if (keys.indexOf(event.key) <= -1) {
        return false;
    }
    return true;
}

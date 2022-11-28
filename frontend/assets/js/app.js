// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"


import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Connect if there are any LiveViews on the page
liveSocket.connect()

// Expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
// The latency simulator is enabled for the duration of the browser session.
// Call disableLatencySim() to disable:
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket


// get items from storage. if nothing is there originally we will get a null value
// const fromStorage = localStorage.getItem('definitions');
// null values are falsey, so if it is null we need to use our default.
// otherwise we just JSON.parse the values we retrieved
// const definitions = !fromStorage ? {
//     "if": null,
//     "when": null,
//     "tomato": null,
// } : JSON.parse(fromStorage);
// I don't feel like running this command everytime I need to reference the tbody,
// thus, the reference to it here.
const tbody = document.querySelectorAll('#definitions');

// adding an event listener on the tbody means that any of the same event that bubble up from it's children will reach here.
// This means you can add children in dynamically without needing to worry so long as they have
// a data-editorShown attribute

tbody.forEach(function(elem) {
    elem.addEventListener('dblclick', e => {
        const parent = e.target.parentElement;
        // if somehow the event gets called from something that is NOT one of the TDs, we don't need to go any further from there.
        // sidenote, all values in the Element.dataset are read as strings. you can set them to be whatever
        // but when you read them, they will be strings.
        if (parent.tagName !== 'H2' || parent.dataset.editorShown === 'true') return;
        // The editor is now shown, so let's set that
        parent.dataset.editorShown = true;

        // get the last TD, which is where we will put our textarea
        const dataTd = parent.querySelector('p');
        // create a new textarea element
        const textarea = document.createElement('INPUT');
        // the textarea gets some class
        textarea.classList.add('full');
        // and a placeholder
        textarea.placeholder = "Input new List Title";

        textarea.setAttribute("type", "text");

        textarea.value = e.target.textContent;

        // the arguments for this function are backwards to me, but I think it's self explanatory what's happening
        dataTd.replaceChild(textarea, dataTd.firstChild);
        // get that focus on the textarea.
        dataTd.firstChild.focus();
    });
});

function blurOrKeypress(e) {
    // split up largely for readability
    if (e.target.tagName !== 'INPUT') return false;
    if (e.type === 'keypress' && e.code != 'Enter' && !e.ctrlKey) return false;

    // a parent, a row, and a newly minted text node walk into a bar...
    const parent = e.target.parentElement;
    const row = parent.parentElement;
    const text = document.createTextNode(e.target.value || ' ');
    /* .isConnected refers to it's state in the DOM. this was some work to try and stop an error that was
        ocurring due to this being simultaneously the 'blur' 'keypress' event handler. Alas, it didn't.
      If the error is really an issue, then wrapping the parent.replaceChild in a try/catch block should solve it for you.*/
    if (e.target.isConnected) {
        // use the dataset key + the textarea's value to update the definitions.
        definitions[row.dataset.key] = e.target.value;
        // write those to the local storage
        localStorage.setItem('definitions', JSON.stringify(definitions));

        // Or, if you are using a database, you would use some variety of AJAX/XHR call here.


        // get rid of our text element
        parent.replaceChild(text, e.target);
        // reset the editorshown value in case we need to update this again
        row.dataset.editorShown = false;

    }

}
// the one thing I miss about jquery event listeners: adding multiple types of event by putting spaces
tbody.forEach(function(elem) {
    elem.addEventListener('keypress', blurOrKeypress);
});
tbody.forEach(function(elem) {
    elem.addEventListener('focusout', blurOrKeypress);
});

// gets the key/value pairs and maps them
// tbody.append(...Object.entries(definitions).map(([word, translation]) => {
//
//     // table row, key TD and value TD cells.
//     const tr = document.createElement('h2');
//     const valueTd = document.createElement('p');
//
//     // editor is not shown by default
//     tr.dataset.editorShown = false;
//     // we use this in an upper function.
//     tr.dataset.key = word;
//
//     // if it's already set, great! use that. otherwise, 'double click to translate'
//     valueTd.innerText = translation || 'Double click to translate';
//     // add these two values to our newly minted tr tag.
//     tr.append(valueTd);
//     // return the TR tag so that the above tbody.append gets an element to actually append
//     return tr;
// }));


const draggables = document.querySelectorAll('.draggable')
const containers = document.querySelectorAll('.sortable.container')

draggables.forEach(draggable => {
    draggable.addEventListener('dragstart', () => {
        draggable.classList.add('dragging')
    })

    draggable.addEventListener('dragend', () => {
        draggable.classList.remove('dragging')
    })
})

containers.forEach(container => {
    container.addEventListener('dragover', e => {
        e.preventDefault()
        const afterElement = getDragAfterElement(container, e.clientY)
        const draggable = document.querySelector('.dragging')
        if (afterElement == null) {
            container.appendChild(draggable)
        } else {
            container.insertBefore(draggable, afterElement)
        }
    })
})

function getDragAfterElement(container, y) {
    const draggableElements = [...container.querySelectorAll('.draggable:not(.dragging)')]

    return draggableElements.reduce((closest, child) => {
        const box = child.getBoundingClientRect()
        const offset = y - box.top - box.height / 2
        if (offset < 0 && offset > closest.offset) {
            return { offset: offset, element: child }
        } else {
            return closest
        }
    }, { offset: Number.NEGATIVE_INFINITY }).element
}
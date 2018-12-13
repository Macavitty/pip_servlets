function draw_plot() {
    fill_areas();
    draw_axises();
    draw_points();
}

function draw_axises() {
    let canvas = document.getElementById("canvas");
    let ctx = canvas.getContext("2d");
    let w = canvas.width;
    let h = canvas.height;
    let tickStep = w / 12;
    let tickCoo = tickStep;
    let space = tickStep / 2;
    ctx.strokeStyle = "black";
    ctx.fillStyle = "black";
    ctx.lineWidth = 1.2;

    // x
    ctx.moveTo(w - space, h / 2);
    ctx.lineTo(space, h / 2);
    ctx.moveTo(w - space, h / 2);
    ctx.lineTo(w - space * 1.2, h / 2 - space / 5);
    ctx.moveTo(w - space, h / 2);
    ctx.lineTo(w - space * 1.2, h / 2 + space / 5);

    //y
    ctx.moveTo(w / 2, space);
    ctx.lineTo(w / 2, h - space);
    ctx.moveTo(w / 2, space);
    ctx.lineTo(w / 2 + space / 5, space * 1.2);
    ctx.moveTo(w / 2, space);
    ctx.lineTo(w / 2 - space / 5, space * 1.2);
    ctx.stroke();

    // ticks and marks
    let tickSize = 8;
    ctx.font = "11px";
    for (let i = -5; i < 6; i++) {
        if (i === 0) {
            ctx.fillText(i + "", tickCoo + tickSize, h / 2 + tickSize * 2);
            tickCoo += tickStep;
        } else {
            ctx.fillRect(tickCoo, h / 2 - tickSize / 2, 0.5, tickSize);
            ctx.fillText(i + "", tickCoo - 1, h / 2 + tickSize * 2);

            ctx.fillRect(h / 2 - tickSize / 2, tickCoo, tickSize, 0.5);
            ctx.fillText(i * (-1) + " ", w / 2 - tickSize * 2, tickCoo + 5);
            tickCoo += tickStep;
        }

    }
}

function draw_points() {
    let canvas = document.getElementById("canvas");
    let ctx = canvas.getContext("2d");
    let w = canvas.width;
    let h = canvas.height;
    const xs = document.querySelectorAll('td.x_coo');
    const ys = document.querySelectorAll('td.y_coo');
    const ress = document.querySelectorAll('td.res_all');
   for (let i = 0; i < xs.length; i++) {
        let x = parseFloat(xs[i].innerText);
        let y = parseFloat(ys[i].innerText);
        let res = ress[i].innerText;
        if (res === 'да')
            ctx.fillStyle = "#aa0f14";
        else if (res === 'нет')
            ctx.fillStyle = "#7e6a97";
        ctx.beginPath();
        let x_on_canvas = get_pos_on_canvas(x, w);
        let y_on_canvas = get_pos_on_canvas(y * (-1), h);
        ctx.moveTo(x_on_canvas, y_on_canvas);
        ctx.arc(x_on_canvas, y_on_canvas, 2.5, Math.PI * 2, 0);
        ctx.fill();
    }
}

function get_pos_on_canvas(coo, par) {
    return (6 + coo) * par / 12;
}

function fill_areas() {
    let canvas = document.getElementById("canvas");
    let ctx = canvas.getContext("2d");
    let w = canvas.width;
    let h = canvas.height;
    let r = document.getElementById("r_input").value;
    let tickStep = w / 12;
    ctx.fillStyle = "#ffbb25";
    r *= tickStep;

    // quarter circle
    ctx.moveTo(w / 2, h / 2);
    ctx.arc(w / 2, h / 2, r, Math.PI * 1.5, 0);
    ctx.fill();

    // triangle
    // without this it keeps drawing border
    ctx.moveTo(w / 2 - r / 2, h / 2);
    ctx.lineTo(w / 2, h / 2);
    ctx.lineTo(w / 2, h / 2 + r);
    ctx.fill();
    ctx.beginPath();

    // rectangle
    ctx.fillRect(w / 2 - r, h / 2 - r, r, r);
    ctx.closePath();

}

function redraw() {
    let canvas = document.getElementById("canvas");
    let w = canvas.width;
    canvas.width = 1;
    canvas.width = w;
    draw_plot();
}

$(function () {

    $('canvas').mousedown(function (e) {
        e.preventDefault();
        let canvas = document.getElementById("canvas");
        let ctx = canvas.getContext("2d");
        let w = canvas.width;
        let h = canvas.height;
        let r = document.getElementById("r_input").value;


        if (r === "") {
            redraw();
            /*ctx.font = "bold 20px";*/
            ctx.fillStyle = "red";
            ctx.textAlign = "center";
            ctx.fillText("УСТАНОВИЕ РАДИУС", w / 4, h / 4);
            ctx.fill();

        } else {
            let coo = getMouseCoords(e);
            let x = coo.x;
            let y = coo.y;
            if (x <= 5 && x >= -5 && y < 5 && y >= -5 && r <= 5 && r >= 1)
                post(x, y, r);
        }
    });
})
;

function getMouseCoords(e) {
    let canvas = document.getElementById("canvas");
    let rect = canvas.getBoundingClientRect();
    let w = canvas.width;
    let h = canvas.height;
    return {
        x: 6 - (w - (e.clientX - rect.left)) * 12 / w,
        y: (6 - (h - (e.clientY - rect.top)) * 12 / h) * (-1)
    };
}

function getMousePos(e) {
    let canvas = document.getElementById("canvas");
    let rect = canvas.getBoundingClientRect();
    return {
        x: e.clientX - rect.left,
        y: e.clientY - rect.top
    };
}

function post(x, y, r) {
    $('<form action="controller" method="post">' +
        '<input type="number" name="x_input" value="' + x + '">' +
        '<input type="number" name="y_input" value="' + y + '">' +
        '<input type="number" name="r_input" value="' + r + '">' +
        '</form>')
        .appendTo('body')
        .submit();
}

draw_plot();
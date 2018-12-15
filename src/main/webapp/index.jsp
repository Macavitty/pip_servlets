<%@ page import="beans.PointsBean, beans.PointRow" %>
<%@ page import="java.util.List" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="results" class="beans.PointsBean" scope="session">
</jsp:useBean>

<html>
<head>
    <meta charset="utf-8">
    <title>PIP LAB#2</title>
    <link rel="SHORTCUT ICON" href="img/duck.png" type="image/png">
    <style> <%@include file='style.css' %> </style>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript">
        <%@include file="js.js"%>
        <%@include file="plot.js"%>
    </script>
</head>


<body>

<div id="container">

    <header class="block">
    <span id="names">
            <h4>Лабораторная работа № 2<br/>
                Вариант 18131</h4><br/>
		Выполнили: Баталов Е. В. и Прилуцкая Т. И. <br/>
		Группа: P3201 <br/>

		</span>
    </header>
    <div id="form_area" class="block">
        <form method="post" action="controller" id="main_form" name="main_form" onsubmit="return validate()">
            <fieldset class="param_field">
                <legend>Х</legend>
                <div class="styled-select, custom-radio">

                    <input type="radio" class="radio-btn" name="x_input" id="a_opt" value="-3">
                    <label for="a_opt" class="label">-3</label>
                    <input type="radio" class="radio-btn" name="x_input" id="b_opt" value="0">
                    <label for="b_opt" class="label">0</label>
                    <input type="radio" name="x_input" id="c_opt" value="3">
                    <label for="c_opt" class="label">3</label><br/>

                    <input type="radio" class="radio-btn" name="x_input" id="d_opt" value="-2">
                    <label for="d_opt" class="label">-2</label>
                    <input type="radio" class="radio-btn" name="x_input" id="e_opt" value="1" checked="checked">
                    <label for="e_opt" class="label">1</label>
                    <input type="radio" class="radio-btn" name="x_input" id="f_opt" value="4">
                    <label for="f_opt" class="label">4</label><br/>

                    <input type="radio" class="radio-btn" name="x_input" id="g_opt" value="-1">
                    <label for="g_opt" class="label">-1</label>
                    <input type="radio" class="radio-btn" name="x_input" id="h_opt" value="2">
                    <label for="h_opt" class="label">2</label>
                    <input type="radio" class="radio-btn" name="x_input" id="i_opt" value="5">
                    <label for="i_opt" class="label">5</label><br/>

                </div>
            </fieldset>
            <fieldset class="param_field">
                <legend>Y</legend>
                <p><input type='text'
                          name='y_input'
                          id="y_input"
                          placeholder="Y є (-5; 5)"
                          autocomplete="off"
                          onkeypress="return disable_not_numbers()"
                          onfocus="removeError(this, this.parentNode)"
                          onpaste="return disable_not_numbers()"
                          maxlength="12"></p>
            </fieldset>
            <fieldset class="param_field">
                <legend class="dangerous_legend">R</legend>
                <div class="styled-select">
                    <select name="r_input" id="r_input" oninput="return redraw()">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3" selected>3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                </div>
            </fieldset>
            <p><input type="submit" name="submit" value="ВЖУХ" id="submit"></p>
        </form>
    </div>

    <div id="canvas_area">
        <canvas id="canvas" width=600 height=600></canvas>
    </div>

    <div id="table_area">
        <table id="res_table">
            <thead>
            <tr>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
                <th class="bool_result">Попадание в область</th>
            </tr>
            </thead>
            <tbody id="tbody">
            <%
                Object obj = request.getSession().getAttribute("results");
                if (!(obj == null)) {
                    List<PointRow> result = ((PointsBean) obj).getResults();
                    for (int i = 0; i < result.size(); ++i) {
                        PointRow resultRow = result.get(i);
                        out.println("<tr>");
                        out.println("<td class=\"x_coo\">" + resultRow.getX() + "</td>");
                        out.println("<td class=\"y_coo\">" + resultRow.getY() + "</td>");
                        out.println("<td class=\"r_coo\">" + resultRow.getR() + "</td>");
                        if (resultRow.getRes() == null)
                            out.println("<td class=\"res_all\"><span>ой, кто-то сломал лабу</span></td>");
                        else if (resultRow.getRes())
                            out.println("<td class=\"res_all\"><span>да</span></td>");
                        else out.println("<td class=\"res_all\"><span>нет</span></td>");
                        out.println("</tr>");
                    }
                }
            %>
            </tbody>
        </table>
    </div>
    <footer class="block">
        <p>
            <a href="http://en.ifmo.ru/en/" target="_blank">
                <img border="0" alt="itmo" src="img/itmo.png" width="120" height="50">
            </a>
        </p>
    </footer>
</div>

<script type="text/javascript" language="javascript">
    function validate() {

        let y = document.forms['main_form']['y_input'],
            yValue = y.value;
        yValue = yValue.replace(/,/g, '.');
        const min_y = -5;
        const max_y = 5;

        if (yValue === "") {
            removeError(y, y.parentNode);
            setError(y, y.parentNode, 'Где Y ?');
            return false;
        } else if (isNaN(yValue)) {
            removeError(y, y.parentNode);
            setError(y, y.parentNode, 'Это не число');
            return false;
        } else if (yValue >= max_y || yValue <= min_y) {
            removeError(y, y.parentNode);
            setError(y, y.parentNode, ' ' + yValue + ' \u{2209} (' + min_y + ' ; ' + max_y + ') !');
            return false;
        }
        return true;
    }
</script>

<script type="text/javascript" src="plot.js"></script>

</body>

</html>

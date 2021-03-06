/**
 * 简单模板
 * @memberOf Bdbox.utils
 * @name template
 * @param  {String} html 模板String内容
 * @param  {Object} data 模板data对象
 * @return {String}      返回处理后的模板
 * @author wangyongqing01
 * @version $Id: template.js 175996 2014-05-16 00:48:03Z wangyongqing01 $
 * @example
 * var t = Bdbox.utils.template('I am <%=name%>', {name:'Theo Wang'});
 * // I am Theo Wang
 * console.log(t);
 */
module.exports = function(html, data) {
    for (var i in data) {
        html = html.replace(new RegExp('<%=\\s*' + i + '\\s*%>', 'g'), data[i]);
    }
    return html;
};

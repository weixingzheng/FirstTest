<!doctype html>
<html>
  <head>
    <title>表格行拖动</title>
    <script>
          window.onload = function(){
        //绑定事件
        var addEvent = document.addEventListener ? function(el,type,callback){
          el.addEventListener( type, callback, !1 );
        } : function(el,type,callback){
          el.attachEvent( "on" + type, callback );
        }
        //移除事件
        var removeEvent = document.removeEventListener ? function(el,type,callback){
          el.removeEventListener( type, callback );
        } : function(el,type,callback){
          el.detachEvent( "on" + type, callback);
        }
        //精确获取样式
        var getStyle = document.defaultView ? function(el,style){
          return document.defaultView.getComputedStyle(el, null).getPropertyValue(style)
        } : function(el,style){
          style = style.replace(/\-(\w)/g, function($, $1){
            return $1.toUpperCase();
          });
          return el.currentStyle[style];
        }
        var dragManager = {
          clientY:0,
          draging:function(e){//mousemove时拖动行
            var dragObj = dragManager.dragObj;
            if(dragObj){
              e = e || event;
              if(window.getSelection){//w3c
                window.getSelection().removeAllRanges();
              }else  if(document.selection){
                document.selection.empty();//IE
              }
              var y = e.clientY;
              var down = y > dragManager.clientY;//是否向下移动
              var tr = document.elementFromPoint(e.clientX,e.clientY);
              if(tr && tr.nodeName == "TD"){
                tr = tr.parentNode
                dragManager.clientY = y;
                if( dragObj !== tr){
                  tr.parentNode.insertBefore(dragObj, (down ? tr.nextSibling : tr));
                }
              };
            }
          },
          dragStart:function(e){
            e = e || event;
            var target = e.target || e.srcElement;
            if(target.nodeName === "TD"){
              target = target.parentNode;
              dragManager.dragObj = target;
              if(!target.getAttribute("data-background")){
                var background = getStyle(target,"background-color");
                target.setAttribute("data-background",background)
              }
              //显示为可移动的状态
              target.style.backgroundColor = "#ccc";
              target.style.cursor = "move";
              dragManager.clientY = e.clientY;
              addEvent(document,"mousemove",dragManager.draging);
              addEvent(document,"mouseup",dragManager.dragEnd);
            }
          },
          dragEnd:function(e){
            var dragObj = dragManager.dragObj
            if (dragObj) {
              e = e || event;
              var target = e.target || e.srcElement;
              if(target.nodeName === "TD"){
                target = target.parentNode;
                dragObj.style.backgroundColor = dragObj.getAttribute("data-background");
                dragObj.style.cursor = "default";
                dragManager.dragObj = null;
                removeEvent(document,"mousemove",dragManager.draging);
                removeEvent(document,"mouseup",dragManager.dragEnd);
              }
            }
          },
          main:function(el){
            addEvent(el,"mousedown",dragManager.dragStart);
          }
        }
        var el = document.getElementById("table");
        dragManager.main(el);
      }
      
    </script>
    <style>
      .table{
        width:60%;
        border: 1px solid red;
        border-collapse: collapse;
      }
      .table td{
        border: 1px solid red;
        height: 20px;
      }
    </style>
  </head>
  <body>
    <h1>表格行拖动</h1>
    <table  id="table" class="table">
      <tbody>
        <tr>
          <td>1</td>
          <td>One</td>
          <td>dom.require</td>
        </tr>
        <tr id="2" >
          <td class="2">2</td>
          <td>Two</td>
          <td>ControlJS </td>
        </tr>
        <tr id="3" >
          <td class="3">3</td>
          <td>Three</td>
          <td>HeadJS</td>
        </tr>
        <tr id="4" >
          <td class="4">4</td>
          <td>Four</td>
          <td>LAB.js</td>
        </tr>
        <tr id="5" >
          <td class="5">5</td>
          <td>Five</td>
          <td>$script.js</td>
        </tr>
        <tr id="6" >
          <td class="6">6</td>
          <td>Six</td>
          <td>NBL.js</td>
        </tr>
      </tbody>
    </table>
  </body>
</html>
<script type="text/javascript">
function aa(){
	//alert($("input[name='cIds']").size());
	
	var a=$("input[name='cIds']");
	var b=$("input[name='cIds']").size();
	$("input[name='cIds']").each(function(){
		console.log($(this).val());
	});
//	for(var c=1;c<=b;c++){
//		console.log(a[c]);
//	}
	
//	alert($("*[name='cIds']").size());
//	var value=$("*[name='cIds']");
//	var i=$("*[name='cIds']").size();
//	for(var d=0;d<i;d++){
//		alert(value[d].innerHTML);
//	}
//	alert($(".list tbody tr td:eq(2)").text());
	var did=$(".list td").text();
	var html = $.ajax({
		  url: "Zone/orderDinnerTable?fid=${zone.id }&did="+did,
		  async: false
		}).responseText;
}
function bb(){
	window.print();
}
</script>
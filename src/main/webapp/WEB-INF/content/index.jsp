<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>

<title>首页</title>

<meta charset="utf-8">
<title>系统首页</title>
<%@include file="script.html" %>
  
<style type="text/css">
    .layout-panel-west {
        border-right: 1px solid #c5c5c5;
    }
</style>
</head>

<body>
	<div id="master-layout">
		<!--顶部banner区开始-->
		<div
			data-options="region:'north',border:false,bodyCls:'theme-header-layout'">
			<div class="theme-navigate">
				<div class="left">
					<h3>京唐国际CRM</h3>
				</div>
				<div class="right">
					<a href="#" class="easyui-menubutton"
						data-options="menu:'#mm1',hasDownArrow:false">消息<span
						class="badge color-orange">15</span></a>

					<div id="mm1" class="theme-navigate-menu-panel"
						style="width:180px;">
						<div>
							站内消息<span class="badge color-success">5</span>
						</div>
						<div>
							公司公告<span class="badge color-important">10</span>
						</div>
						<div>服务消息</div>
						<div class="menu-sep"></div>
						<div>查看历史消息</div>
						<div class="menu-sep"></div>
						<div>清除消息提示</div>
					</div>
					<a href="#" class="easyui-menubutton theme-navigate-user-button"
						data-options="menu:'.theme-navigate-user-panel'">${sessionScope.user.username }</a>

					<div class="theme-navigate-user-panel">
						<dl>
							<dd>
								<img src="static/easyui/themes/insdep/images/portrait86x86.png" width="86" height="86"> 
								<b class="badge-prompt">${sessionScope.user.username }</b> 
								<span>${sessionScope.user.email}</span>

								<p>
									安全等级：<i class="text-success">高</i>
								</p>
							</dd>
							<dt>
								<a class="theme-navigate-user-modify">修改资料</a> 
								<a class="theme-navigate-user-logout">注销</a>
							</dt>
						</dl>
					</div>
				</div>
			</div>

		</div>
		<!--顶部banner区结束-->
		<!--左侧系统菜单区开始-->
		<div data-options="region:'west',split:true,border:false" title="系统菜单" style="width:230px; padding:10px 20px;">
			<ul id="menu" ></ul>
		</div>
		<!--左侧系统菜单区结束-->
		<!--右侧功能展示区开始-->
		<div id="tabs" data-options="region:'center',border:false,height:800" class="easyui-tabs">
			<div id="tab1" title="个人中心">
				<div class="theme-user-info-panel">
					<div class="left">
						<img src="static/easyui/themes/insdep/images/portrait86x86.png" width="86" height="86">
					</div>
					<div class="right">
						<ul>
							<li class="text-success">￥6,200.00<span>完成合同金额</span></li>
							<li class="text-info">33<span>月度客户数</span></li>
							<li class="text-warning">9820<span>月度任务额</span></li>
							<li>125<span>月度线索数</span></li>
						</ul>
					</div>
					<div class="center">
						<h1>
							${sessionScope.user.username }<span class="badge color-success">已认证</span>
						</h1>

						<h2>
							角色名
						</h2>
						<ul>
							<li><i class="iconfont">&#xe61c;</i> ${sessionScope.user.email}</li>
							<li><i class="iconfont">&#xe65d;</i> ${sessionScope.user.phone}</li>
						</ul>
					</div>
				</div>

				<div id="user-info-more"
					class="easyui-tabs theme-tab-blue-line theme-tab-body-unborder"
					data-options="tools:'#tab-tools',fit:true">
					<div title="待办事项" style="padding:10px"></div>
					<div title="任务列表" style="padding:10px"></div>
					<div title="站内信息" style="padding:10px"></div>
				</div>
			</div>
		</div>
		<!--右侧功能展示区结束-->
		<div id="topWindow"  style="overflow: hidden;"></div>
	</div>

	<script type="text/javascript">
		function addTab(title,url){
			var exists = $("#tabs").tabs("exists",title);
			if(exists){
				$("#tabs").tabs("select",title);
			}else{
				$("#tabs").tabs("add",{
					"title" : title,
					"closable" : true,
					"content" : "<iframe width='100%' height='100%' frameborder='0' scrolling='no' src='"+url+"'></iframe>", 
					"border" : false,
					"fit" : true
				});
			}
		}

		/**
		 *@param options -模式窗口需要参数对象，该对象有以下可选属性 width,hegiht,title,url,onClose
		 **/
		function openTopWindow(options){
			//因为窗口的options对象的所有属性是可选的，因此需要在没有传递参数时设置默认值
			options.width = !options.width ? 800 : options.width;
			options.height = !options.height ? 500 : options.height;
			options.onClose = !options.onClose ? function(){} : options.onClose;

			if(!options.url){
				throw "新弹出窗口必须设置URL属性";
			}
			
			$("#topWindow").window({
				"title" : options.title,
				"width" : options.width,
				"height" : options.height,
				"content" : "<iframe width='100%' height='100%' frameborder='0' scrolling='no' src='"+options.url+"'></iframe>",
				"onClose" : options.onClose,
				"modal" : true
				
			});
		}

		function closeTopWindow(){
			$("#topWindow").window("close");
		}
		
		
		$(function(){
			//初始化菜单树
			$("#menu").tree({
				"url" : "system/menu",
				"loadFilter" : function(data){
					if(data && data.success){
						return data.result;
					}
					return null;
				},
				"onClick" : function(node){
					if(node && node.attributes){
						if(node.attributes.url){
							addTab(node.text, node.attributes.url);
						}
					}
				}
			});
		});
		
		$(function () {
	        /*布局部分*/
	        $('#master-layout').layout({
	            fit: true/*布局框架全屏*/
	        });
	
	        $(".navigate-user-modify").on("click", function () {
	            $('.navigate-user-panel').menu('hide');
	           // $.insdep.window({id: "personal-set-window", href: "user.html", title: "修改资料"});
	        });
	    });
	</script>
</html>

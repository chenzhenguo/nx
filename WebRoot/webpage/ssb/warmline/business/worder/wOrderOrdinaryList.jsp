<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div id="product" class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="wOrderOrdinaryList" checkbox="false" fitColumns="true" title="普通订单" actionUrl="wOrderController.do?ordinaryDatagrid" 
  idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="group"  ></t:dgCol>
   <t:dgCol title="标题"  field="title"    queryMode="group" width="140" ></t:dgCol>
<%--    <t:dgCol title="副标题"  field="subtitle" hidden="true"  hidden="true"  queryMode="group"  ></t:dgCol>
   <t:dgCol title="描述"  field="description"   hidden="true" queryMode="group"  ></t:dgCol> --%>
    <t:dgCol title="订单号"  field="orderNumber"   query="true"  queryMode="single"  width="100"  ></t:dgCol>
   <t:dgCol title="类别"  field="category" dictionary="category"   queryMode="single"  width="60"  ></t:dgCol>
  <%--  <t:dgCol title="相片"  field="photos"   hidden="true"   queryMode="group"  ></t:dgCol> --%>
   <t:dgCol title="价格"  field="price" queryMode="group"  width="50" ></t:dgCol>
   <t:dgCol title="发布人"  field="issuer"   query="true"  queryMode="single"   width="80" ></t:dgCol>
   <t:dgCol title="发布人id"  field="issuerId"  hidden="true"   queryMode="group"  ></t:dgCol>
   <t:dgCol title="发布人电话"  field="phone" query="true"  queryMode="single" width="100"></t:dgCol>
   <t:dgCol title="位置信息"  field="location" queryMode="group" width="260" ></t:dgCol>
  <%--  <t:dgCol title="国家"  field="state"   hidden="true" queryMode="group"  ></t:dgCol> --%>
   <t:dgCol title="城市"  field="city" queryMode="group"  ></t:dgCol>
   <t:dgCol title="接单人联系电话"  field="orderPersonPhone"  query="true"   queryMode="single"   width="100" ></t:dgCol>
<%--  <t:dgCol title="求助类型"  field="seekStatus" dictionary="seekstatus" hidden="true"  queryMode="group"  ></t:dgCol> --%>
   <t:dgCol title="接单人姓名"  field="orderPersonName"   query="true"  queryMode="single"   width="80" ></t:dgCol>
   <t:dgCol title="接单人id"  field="orderPersonId"    hidden="true" queryMode="single"  ></t:dgCol>
    <t:dgCol title="订单状态"  field="orderStatus" dictionary="orderstatu" query="true"   queryMode="single"  width="80" ></t:dgCol>
    <t:dgCol title="订单开始时间"  field="startTime" formatter="yyyy-MM-dd hh:mm:ss" query="true"  queryMode="group"  ></t:dgCol>
   <t:dgCol title="订单结束时间"  field="endTime" formatter="yyyy-MM-dd hh:mm:ss" query="true"  queryMode="group"  ></t:dgCol>
   <t:dgCol title="下单时间"  field="orderTime" formatter="yyyy-MM-dd hh:mm:ss"   queryMode="group"  ></t:dgCol>
   <t:dgCol title="支付状态"  field="buyStatus"   query="true" dictionary="buyStatus"   queryMode="single"  ></t:dgCol>
   <%-- <t:dgCol title="支付方式"  field="paymentMode"  query="true" hidden="true" dictionary="" queryMode="single"  ></t:dgCol> --%>
 <%--   <t:dgCol title="订单类型"  field="orderType"  dictionary="ordeTrype"  queryMode="group"  ></t:dgCol> --%>
   <%--  <t:dgCol title="距离"  field="distance" queryMode="single"  ></t:dgCol> --%>
    <t:dgCol title="操作" field="opt" ></t:dgCol>
    <t:dgFunOpt funname="queryUserInformation(issuerId)"  operationCode="queryUserInformation"  title="查看发布人信息"   ></t:dgFunOpt>
    <t:dgFunOpt funname="queryHistoryOrder(issuerId)"  operationCode="queryHistoryOrder"  title="查看历史订单"   ></t:dgFunOpt>
    <t:dgFunOpt funname="applicantNumber(id)"  operationCode="applicantNumber"  title="申请人数量"   ></t:dgFunOpt>
   <t:dgToolBar title="查看" icon="icon-search" url="wOrderController.do?goUpdate" funname="detail"></t:dgToolBar> 
   <%-- <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar> --%>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
  <%--  <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
  <div data-options="region:'south',
	collapsed:true,
	split:true,
	border:false,
	onExpand : function(){
		li_east = 1;
	},
	onCollapse : function() {
	    li_east = 0;
	}"
	style="width: 400px;height:200px; overflow: hidden;" id="eastPanel">
    <div class="easyui-panel" style="padding:0px;border:0px" fit="true" border="false" id="panel"></div>
</div>
 <script src = "webpage/ssb/warmline/business/worder/wOrderList.js"></script>		
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
	//给时间控件加上样式
		$("#wOrderOrdinaryListtb").find("input[name='orderTime_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});});
		$("#wOrderOrdinaryListtb").find("input[name='orderTime_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});});
		$("#wOrderOrdinaryListtb").find("input[name='startTime_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});});
		$("#wOrderOrdinaryListtb").find("input[name='startTime_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});});
		$("#wOrderOrdinaryListtb").find("input[name='endTime_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});});
		$("#wOrderOrdinaryListtb").find("input[name='endTime_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});});
 });
	//发布人信息
 function queryUserInformation(issuerId) {
 			var title = '<t:mutiLang langKey="发布人信息"/>';
 			if (li_east == 0
 					|| $('#product').layout('panel', 'south')
 							.panel('options').title != title) {
 				$('#product').layout('expand', 'south');
 			}
 			$('#product').layout('panel', 'south').panel('setTitle', title);
 			$('#product').layout('panel', 'south').panel('resize', {height : 210});
 			$('#panel').panel("refresh","userController.do?orderUser&issuerId="+issuerId);
 		}
	
	
	//历史订单
 function queryHistoryOrder(issuerId) {
 			var title = '<t:mutiLang langKey="历史订单"/>';
 			if (li_east == 0
 					|| $('#product').layout('panel', 'south')
 							.panel('options').title != title) {
 				$('#product').layout('expand', 'south');
 			}
 			$('#product').layout('panel', 'south').panel('setTitle', title);
 			$('#product').layout('panel', 'south').panel('resize', {height : 300});
 			$('#panel').panel("refresh","wOrderController.do?historyOrder&issuerId="+issuerId);
 	
	}
	
	
 function applicantNumber(id) {
		var title = '<t:mutiLang langKey="历史订单"/>';
		if (li_east == 0
				|| $('#product').layout('panel', 'south')
						.panel('options').title != title) {
			$('#product').layout('expand', 'south');
		}
		$('#product').layout('panel', 'south').panel('setTitle', title);
		$('#product').layout('panel', 'south').panel('resize', {height : 300});
		$('#panel').panel("refresh","wHelpMessageController.do?applicantNumber&orderId="+id);

}
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'wOrderController.do?upload', "wOrderList");
}

//导出
function ExportXls() {
	JeecgExcelExport("wOrderController.do?exportXls","wOrderList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("wOrderController.do?exportXlsByT","wOrderList");
}
 </script>
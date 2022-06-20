﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master/SchoolMain.Master" AutoEventWireup="true" CodeBehind="JournalEntry.aspx.cs" Inherits="GEIMS.Accounting.JournalEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<script type="text/javascript">
	    function calendarShown(sender, args) {
	        sender._popupBehavior._element.style.zIndex = 10005;
	    }
	</script>
	<script>
	    $(function () {
	        $(document.getElementById('<%= tabs.ClientID %>')).tabs();
		});
	</script>
	<script language="javascript" type="text/javascript">
	    function focusDebitCreditText(ctrlID) {
	        var gridViewID = "<%=GvEntry.ClientID %>";
		    var gridView = document.getElementById(gridViewID);
		    var gridViewControls = gridView.getElementsByTagName("input");
		    for (i = 0; i < gridViewControls.length; i++) {
		        if (i == eval(ctrlID)) {
		            gridViewControls[i].style.backgroundColor = "#DDFFAA";
		        }
		        else {
		            gridViewControls[i].style.backgroundColor = "#FFFFFF";
		        }
		    }
		}
		function clearFocus() {
		    var gridViewID = "<%=GvEntry.ClientID %>";
            var gridView = document.getElementById(gridViewID);
            var gridViewControls = gridView.getElementsByTagName("input");
            //alert(gridViewControls);
            for (i = 0; i < gridViewControls.length; i++) {
                gridViewControls[i].style.backgroundColor = "#FFFFFF";
            }
        }
        function makeTextBoxFocus(rowID) {
            var gridViewID = "<%=GvEntry.ClientID %>";
            var gridView = document.getElementById(gridViewID);
            var gridViewControls = gridView.getElementsByTagName("input");


            var credSum = document.getElementById(gridViewControls[gridViewControls.length - 1].id).value;
            var debSum = document.getElementById(gridViewControls[gridViewControls.length - 2].id).value;

            if (eval(credSum) == eval(debSum)) {
                var sel = 4 * rowID;
                gridViewControls[sel].focus();
            }
            else if (eval(credSum) < eval(debSum)) {
                var sel = (4 * rowID) + 2;
                gridViewControls[sel].focus();
            }
            else if (eval(credSum) > eval(debSum)) {
                var sel = 4 * rowID;
                gridViewControls[sel].focus();
            }
        }
        function enableDisableCreditText(rowID) {
            var gridViewID = "<%=GvEntry.ClientID %>";
            var gridView = document.getElementById(gridViewID);
            var gridViewControls = gridView.getElementsByTagName("input");

            for (i = 0; i < gridViewControls.length; i += 2) {
                var tmp = i / 4;
                if (tmp == rowID) {
                    if (gridViewControls[i].value != "")
                        gridViewControls[i + 2].disabled = true;
                    else
                        gridViewControls[i + 2].disabled = false;
                }
            }
        }
        function enableDisableDebitText(rowID) {
            var gridViewID = "<%=GvEntry.ClientID %>";
            var gridView = document.getElementById(gridViewID);
            var gridViewControls = gridView.getElementsByTagName("input");

            for (i = 0; i < gridViewControls.length; i += 2) {
                var tmp = (i / 4);
                if (tmp == rowID) {
                    if (gridViewControls[i + 2].value != "")
                        gridViewControls[i].disabled = true;
                    else
                        gridViewControls[i].disabled = false;
                }
            }
        }
        function makeDebitSum() {
            var gridViewID = "<%=GvEntry.ClientID %>";
            var gridView = document.getElementById(gridViewID);
            var gridViewControls = gridView.getElementsByTagName("input");
            var sumVal = 0;

            for (i = 0; i < gridViewControls.length - 2; i = i + 4) {
                var ctrlVal = gridViewControls[i].value;
                ctrlVal = Math.max(ctrlVal, 0);
                sumVal = eval(sumVal) + eval(ctrlVal);
            }
            var len = gridViewControls.length;
            var debID = gridViewControls[len - 2].id;
            document.getElementById(debID).value = sumVal.toString();
            //document.getElementById(gridViewControls[length-2].id).value = sumVal;
            //document.getElementById("txtDebitSum").value = sumVal;
        }
        function makeCreditSum() {
            var gridViewID = "<%=GvEntry.ClientID %>";
            var gridView = document.getElementById(gridViewID);
            var gridViewControls = gridView.getElementsByTagName("input");
            var sumVal = eval(0);

            for (i = 2; i < gridViewControls.length - 2; i = i + 4) {
                var ctrlVal = gridViewControls[i].value;
                ctrlVal = Math.max(ctrlVal, 0);
                sumVal = eval(sumVal) + eval(ctrlVal);
            }
            var len = gridViewControls.length;
            var credID = gridViewControls[len - 1].id;
            document.getElementById(credID).value = sumVal;

            //document.getElementById("txtCreditSum").value = sumVal;
            //document.getElementById(gridViewLabels[1].id).value = sumVal.toString();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<script type="text/javascript">
	    $(function () {
	        $('#id_search').quicksearch('table#<%=gvJournalEntry.ClientID%> tbody tr');
		})
	</script>
	<div id="divCurrenTabSelected" class="hidden" visible="false">div4</div>
	<div id="divMain" style="width: 100%; text-align: left; padding-top: 5px;">
		<div id="divTitle" class="pageTitle" style="width: 100%;">
			Journal Entry
			 <asp:LinkButton CausesValidation="false" ID="btnAddNew" runat="server" CssClass="btn-blue btn-blue-medium Detach" OnClick="btnAddNew_Click">Add New</asp:LinkButton>
			&nbsp;
			 <asp:LinkButton CausesValidation="false" ID="btnViewList" runat="server" CssClass="btn-blue btn-blue-medium Detach" OnClick="btnViewList_Click">View List</asp:LinkButton>
		</div>
		<div id="divContent" style="height: 100%; font-family: Verdana;">
			<div id="divContent1" style="width: 10%; float: left; height: 100%; color: white;">1</div>
			<div id="divContent2" style="width: 80%; float: left; height: 100%;">
				<div id="Div1" align="center">
					<asp:Label ID="lblDuration" runat="server" CssClass="label"></asp:Label>
				</div>
				<div id="divGrid" runat="server" style="text-align: center; padding-top: 10px; padding-bottom: 10px; padding-right:10px; width: 100%;">
					<div id="search">
						<input id="id_search" type="text" placeholder="Search" onkeydown="return (event.keyCode!=13);">
					</div>
					<br />
					<asp:GridView ID="gvJournalEntry" runat="server" AutoGenerateColumns="False"
						BorderColor="#3B5998" BorderWidth="3px" BorderStyle="Solid" CellPadding="4" GridLines="Both"
						Font-Names="verdana" Font-Size="12px" Width="100%" BackColor="White" OnPreRender="gvJournalEntry_PreRender" OnRowCommand="gvJournalEntry_RowCommand" OnRowEditing="gvJournalEntry_RowEditing" OnSelectedIndexChanged="gvJournalEntry_SelectedIndexChanged">
						<FooterStyle BackColor="White" ForeColor="#333333" />
						<RowStyle BackColor="White" Height="20px" ForeColor="#333333" />
						<Columns>
							<asp:BoundField DataField="VoucherCode" HeaderText="Voucher No">
								<HeaderStyle Width="15%" HorizontalAlign="left" VerticalAlign="Top" />
								<ItemStyle HorizontalAlign="left" Width="15%" VerticalAlign="Top" Wrap="true" />
							</asp:BoundField>
							<asp:BoundField DataField="VoucherDate" HeaderText="Voucher Date">
								<HeaderStyle Width="15%" HorizontalAlign="left" VerticalAlign="Top" />
								<ItemStyle HorizontalAlign="left" Width="15%" VerticalAlign="Top" Wrap="true" />
							</asp:BoundField>
							<asp:BoundField DataField="AccountName" HeaderText="Account Name">
								<HeaderStyle Width="50%" HorizontalAlign="left" VerticalAlign="Top" />
								<ItemStyle HorizontalAlign="left" Width="50%" VerticalAlign="Top" Wrap="true" />
							</asp:BoundField>
							<asp:BoundField DataField="Amount" HeaderText="Amount">
								<HeaderStyle Width="20%" HorizontalAlign="left" VerticalAlign="Top" />
								<ItemStyle HorizontalAlign="left" Width="20%" VerticalAlign="Top" Wrap="true" />
							</asp:BoundField>
							<asp:TemplateField HeaderText="Edit">
								<ItemTemplate>
									<asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="false" ImageUrl="~/Images/Edit.png"
										CommandName="Edit1" CommandArgument='<%# Eval("VoucherCode")%>' Height="20px" Width="20px" />
								</ItemTemplate>
								<HeaderStyle HorizontalAlign="center" />
								<ItemStyle HorizontalAlign="center" Width="10%" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Delete">
								<ItemTemplate>
									<asp:ImageButton ID="ImageButton4" runat="server" CausesValidation="false" ImageUrl="~/Images/delete-1.png"
										CommandName="Delete1" CommandArgument='<%# Eval("VoucherCode")%>' OnClientClick="javascript:return confirm('Are you sure, you want to delete this Record?');"
										Height="20px" Width="20px" />
								</ItemTemplate>
								<HeaderStyle HorizontalAlign="center" />
								<ItemStyle HorizontalAlign="center" Width="10%" />
							</asp:TemplateField>
						</Columns>
						<FooterStyle BackColor="#3B5998" Font-Bold="True" Font-Names="Verdana" Font-Size="12px" />
						<PagerStyle BackColor="#3B5998" ForeColor="White" HorizontalAlign="center" />
						<SelectedRowStyle BackColor="#2B558E" Font-Bold="True" ForeColor="White" />
						<HeaderStyle BackColor="#3B5998" Font-Bold="True" ForeColor="White" />
					</asp:GridView>
				</div>

				<div id="tabs" runat="server" class="style-tabs" visible="true" style="width: 100%;">
					<ul>
						<li><a id="tabStudentTemplateDetails" href="#tabs-1">Journal Entry</a></li>
					</ul>
					<div id="tabs-1" style="padding:0 0 0 10px" class="gradientBoxesWithOuterShadows">
						<%--<fieldset>--%>
						<div class="divclasswithfloat">
							<div style="text-align: left; width: 15%; float: left;" class="label">
								Date :<span class="Required">*</span>
							</div>
							<div style="text-align: left; width: 35%; float: left;">
								<asp:TextBox runat="server" ID="txtDate" CssClass="validate[required] TextBox" Width="190px"></asp:TextBox>
								<ajaxToolkit:CalendarExtender ID="txtFrom_CalendarExtender" runat="server" Enabled="True"
									Format="dd/MM/yyyy" TargetControlID="txtDate">
								</ajaxToolkit:CalendarExtender>
							</div>
							<div style="text-align: left; width: 15%; float: left;" class="label">
								Voucher No :<span class="Required">*</span>
							</div>
							<div style="text-align: left; width: 35%; float: left;">
								<asp:TextBox runat="server" ID="txtVoucherCode" CssClass="TextBox detach" Width="190px" BackColor="#cae4ff"></asp:TextBox>
							</div>
						</div>
						<div class="divclasswithfloat">
							<div style="text-align: left; width: 15%; float: left;" class="label">
								Section :<span class="Required">*</span>
							</div>
							<div style="text-align: left; width: 35%; float: left;">
								<asp:DropDownList ID="ddlSection"  CssClass="validate[required] Droptextarea" runat="server" AutoPostBack="True"  >
                                    <asp:ListItem Value="-1">-Select-</asp:ListItem>                                          
                                </asp:DropDownList>
							</div>
							<div style="text-align: left; width: 15%; float: left;" class="label">
								Budget Category :<span class="Required">*</span>
							</div>
							<div style="text-align: left; width: 35%; float: left;">
								<asp:DropDownList ID="ddlBudgetCategory"  CssClass="validate[required] Droptextarea" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBudgetCategory_SelectedIndexChanged"  >
                                    <asp:ListItem Value="-1">-Select-</asp:ListItem>                                          
                                </asp:DropDownList>
							</div>
						</div>
						<div class="divclasswithfloat">
							<div style="text-align: left; width: 15%; float: left;" class="label">
								Budget Heading :<span class="Required">*</span>
							</div>
							<div style="text-align: left; width: 35%; float: left;">
								 <asp:DropDownList ID="ddlBudgetHeading"  CssClass="validate[required] Droptextarea" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBudgetHeading_SelectedIndexChanged"   >
									   <asp:ListItem Value="-1">-Select-</asp:ListItem>                                          
                                 </asp:DropDownList>
							</div>
							<div style="text-align: left; width: 15%; float: left;" class="label">
								Budget SubHeading :<span class="Required">*</span>
							</div>
							<div style="text-align: left; width: 35%; float: left;">
								<asp:DropDownList ID="ddlBudgetSubHeading"  CssClass="validate[required] Droptextarea" runat="server" AutoPostBack="True"    >
                                      <asp:ListItem Value="-1">-Select-</asp:ListItem>                                          
                                </asp:DropDownList>    
							</div>
						</div>
						<div class="divclasswithfloat" width="100%">
							<div class="label" align="center">
								<asp:GridView ID="GvEntry" runat="server" AutoGenerateColumns="False" ShowFooter="True" Width="776px">
									<Columns>
										<asp:TemplateField HeaderText="Account Name" FooterText="Total Amount">
											<ItemTemplate>
												<asp:DropDownList ID="ddlAccountName" runat="server" CssClass="Droptextarea"
													Font-Names="Verdana" Font-Size="12px" Width="510px">
												</asp:DropDownList>
											</ItemTemplate>
											<FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="Debit Amount">
											<ItemTemplate>
												<asp:TextBox ID="txtDebitAmount" runat="server" CssClass="TextBox"
													Font-Names="Verdana" Height="13px" onblur="howManyDecimals(this.id,'#FFDFDF')" onkeypress="return NumericKeyPressFraction(event)" Style="text-align: right;" Width="100px"></asp:TextBox>
												<ajaxToolkit:FilteredTextBoxExtender ID="txtDebitAmount_FilteredTextBoxExtender"
													runat="server" Enabled="True" TargetControlID="txtDebitAmount"
													ValidChars="0,1,2,3,4,5,6,7,8,9,.">
												</ajaxToolkit:FilteredTextBoxExtender>
												<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
													ControlToValidate="txtDebitAmount" CssClass="Required"
													ErrorMessage="Invalid Amount" ValidationExpression="\d{0,8}(.)?(\d{0,2})">*</asp:RegularExpressionValidator>
												<ajaxToolkit:ValidatorCalloutExtender ID="RegularExpressionValidator1_ValidatorCalloutExtender"
													runat="server" Enabled="True" TargetControlID="RegularExpressionValidator1">
												</ajaxToolkit:ValidatorCalloutExtender>
											</ItemTemplate>
											<FooterTemplate>
												<input id="txtDebitSum" runat="server" class="TextBox" disabled="disabled" style="text-align: right; width: 100px; height: 13px;" value="0" />
											</FooterTemplate>
										</asp:TemplateField>
										<asp:TemplateField HeaderText="Credit Amount">
											<ItemTemplate>
												<asp:TextBox ID="txtCreditAmount" runat="server" CssClass="TextBox"
													Font-Names="Verdana" onblur="howManyDecimals(this.id,'#FFDFDF')" onkeypress="return NumericKeyPressFraction(event)" Style="text-align: right;" Width="100px" Height="13px"></asp:TextBox>
												<ajaxToolkit:FilteredTextBoxExtender ID="txtCreditAmount_FilteredTextBoxExtender"
													runat="server" Enabled="True" TargetControlID="txtCreditAmount"
													ValidChars="0,1,2,3,4,5,6,7,8,9,.">
												</ajaxToolkit:FilteredTextBoxExtender>
												<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
													ControlToValidate="txtCreditAmount" CssClass="Required"
													ErrorMessage="Invalid Amount" ValidationExpression="\d{0,8}(.)?(\d{0,2})">*</asp:RegularExpressionValidator>
												<ajaxToolkit:ValidatorCalloutExtender ID="RegularExpressionValidator2_ValidatorCalloutExtender"
													runat="server" Enabled="True" TargetControlID="RegularExpressionValidator2">
												</ajaxToolkit:ValidatorCalloutExtender>
											</ItemTemplate>
											<FooterTemplate>
												<input id="txtCreditSum" runat="server" class="TextBox" disabled="disabled" style="text-align: right; width: 100px; height: 13px;" type="text" value="0" />
											</FooterTemplate>
										</asp:TemplateField>
										<asp:BoundField HeaderText="JournalID" Visible="False" />
									</Columns>
									<FooterStyle BackColor="#2b558e" Font-Bold="True" Font-Names="Verdana" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
									<HeaderStyle BackColor="#2b558e" Font-Names="Verdana" Font-Size="12px" ForeColor="White" Height="20px" />
								</asp:GridView>
							</div>
						</div>
						<div class="divclasswithfloat" width="100%">
							<div class="label" align="center">
								<asp:Button ID="btnAddRow" runat="server" Text="Add New Row" CssClass="btn-blue-new btn-blue-small Detach" Height="25px" OnClick="btnAddRow_Click" />
							</div>
						</div>
						<div class="divclasswithfloat">
							<div style="text-align: left; width: 15%; float: left;" class="label">
								Narration :<%--<span class="Required">*</span>--%>
							</div>
							<div style="text-align: left; width: 85%; float: left;">
								<asp:TextBox runat="server" ID="txtNarration" CssClass="TextBox" Width="700px" TextMode="MultiLine" Rows="3"></asp:TextBox>
							</div>
							
						</div>
						<div class="divclasswithoutfloat">
							<asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-blue-new btn-blue-medium" OnClick="btnSave_Click" style="left: -8px; top: -3px" />
						</div>
						<%--</fieldset>--%>
					</div>
				</div>
				<div id="divContent3" style="width: 10%; float: right;"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	    jQuery("#aspnetForm").validationEngine('attach', {
	        promptPosition: "bottomRight",
	        validationEventTrigger: "submit",
	        validateNonVisibleFields: false,
	        updatePromptsPosition: true
	    });
	    $(document.getElementById('<%= btnSave.ClientID %>')).click(function () {
		    var valid = $("#aspnetForm").validationEngine('validate');
		    var vars = $("#aspnetForm").serialize();
		});
	</script>
</asp:Content>

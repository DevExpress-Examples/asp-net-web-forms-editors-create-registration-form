<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationForm1.aspx.cs"
	Inherits="ASPxEditorsTutorial.RegistrationForm" %>

<%@ Register Assembly="DevExpress.Web.v24.2, Version=24.2.1.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web" TagPrefix="dx" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<script type="text/javascript">
		function OnPassValidation(s, e) {
			var errorText = GetErrorText(s);
			if (errorText) {
				e.isValid = false;
				e.errorText = errorText;
			}
		}

		var passwordMinLength = 6;
		function GetPasswordStrength(password) {
			var result = 0;
			if (password) {
				result++;
				if (password.length >= passwordMinLength) {
					if (/[a-z]/.test(password))
						result++;
					if (/[A-Z]/.test(password))
						result++;
					if (/\d/.test(password))
						result++;
					if (!(/^[a-z0-9]+$/i.test(password)))
						result++;
				}
			}
			return result;
		}

		function ApplyCurrentPasswordStrength(s, e) {
			var password = passwordTextBox.GetText();
			var passwordStrength = GetPasswordStrength(password);
			ApplyPasswordStrength(passwordStrength);
		}
		function ApplyPasswordStrength(value) {
			ratingControl.SetValue(value);
			switch (value) {
				case 1:
					ratingLabel.SetValue("Too simple");
					break;
				case 2:
					ratingLabel.SetValue("Not safe");
					break;
				case 3:
					ratingLabel.SetValue("Normal");
					break;
				case 4:
					ratingLabel.SetValue("Safe");
					break;
				case 5:
					ratingLabel.SetValue("Very safe");
					break;
				default:
					ratingLabel.SetValue("Password safety");
			}
		}
		function GetErrorText(editor) {
			if (editor === passwordTextBox) {
				if (ratingControl.GetValue() === 1)
					return "The password is too simple";
			} else if (editor === confirmPasswordTextBox) {
				if (passwordTextBox.GetText() !== confirmPasswordTextBox.GetText())
					return "The passwords you entered do not match";
			}
			return "";
		}

		function CheckEmailCallbackComplete(s, e) {
			if (e.result == "True") {
				eMailTextBox.SetIsValid(false);
				eMailTextBox.SetErrorText("");
				emailStatusLabel.SetText("This email belongs to an existing account");
				emailStatusLabel.GetMainElement().style.color = "red";
			}
			else {
				emailStatusLabel.SetText("This Email is free");
				emailStatusLabel.GetMainElement().style.color = "green";
			}
			loadingPanel.Hide();
		}

		function OnCheckEmailImageClick(s, e) {
			eMailTextBox.Validate();
			if (eMailTextBox.GetIsValid())
				CheckEmailCallback.PerformCallback();
		}

	</script>
</head>
<body>
	<form id="form1" runat="server">
	<dx:ASPxFormLayout ID="registrationFormLayout" runat="server" AlignItemCaptionsInAllGroups="True"
		Width="600px">
		<Items>
			<dx:LayoutGroup Caption="Registration Data" GroupBoxDecoration="HeadingLine" SettingsItemCaptions-HorizontalAlign="Right"
				ColCount="2">
				<Items>
					<dx:LayoutItem Caption="Name">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer>
								<dx:ASPxTextBox ID="firstNameTextBox" runat="server" NullText="First Name..." Width="170px"
									OnValidation="requiredTextBox_Validation">
									<ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" SetFocusOnError="True">
										<RequiredField IsRequired="True" />
									</ValidationSettings>
								</dx:ASPxTextBox>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
					<dx:LayoutItem Caption="Last Name" ShowCaption="False">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer>
								<dx:ASPxTextBox ID="lastNameTextBox" runat="server" NullText="Last Name..." Width="170px"
									OnValidation="requiredTextBox_Validation">
									<ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" SetFocusOnError="True">
										<RequiredField IsRequired="True" />
									</ValidationSettings>
								</dx:ASPxTextBox>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
					<dx:LayoutItem Caption="Gender">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer>
								<dx:ASPxRadioButtonList ID="genderRadioButtonList" runat="server" RepeatDirection="Horizontal"
									Width="170px" OnValidation="requiredTextBox_Validation">
									<Items>
										<dx:ListEditItem Text="Male" Value="Male" />
										<dx:ListEditItem Text="Female" Value="Female" />
									</Items>
									<ValidationSettings Display="Dynamic" ErrorDisplayMode="Text">
										<RequiredField IsRequired="True" />
									</ValidationSettings>
									<Border BorderStyle="None" />
								</dx:ASPxRadioButtonList>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
					<dx:LayoutItem Caption="Birth Date">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer>
								<dx:ASPxDateEdit ID="birthDateEdit" runat="server" OnValidation="requiredTextBox_Validation">
									<ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" SetFocusOnError="True">
										<RequiredField IsRequired="True" />
									</ValidationSettings>
									<ClientSideEvents Init="function(s, e){  s.GetCalendar().SetVisibleDate(new Date (1995,1,1)); }" />
								</dx:ASPxDateEdit>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
					<dx:LayoutItem Caption="Country">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer>
								<dx:ASPxComboBox runat="server" ID="countryComboBox" DataSourceID="AccessDataSourceCountry"
									TextField="Country" ValueField="CountryID" IncrementalFilteringMode="StartsWith">
									<ClientSideEvents SelectedIndexChanged="function(s, e) { cityClientComboBox.PerformCallback(s.GetValue()); }" />
								</dx:ASPxComboBox>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
					<dx:LayoutItem Caption="City">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server"
								SupportsDisabledAttribute="True">
								<dx:ASPxComboBox ID="cityComboBox" runat="server" ClientInstanceName="cityClientComboBox"
									DataSourceID="AccessDataSourceCities" IncrementalFilteringMode="StartsWith" OnCallback="cityComboBox_Callback"
									TextField="City" ValueField="City">
								</dx:ASPxComboBox>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
				</Items>
				<SettingsItemCaptions HorizontalAlign="Right"></SettingsItemCaptions>
			</dx:LayoutGroup>
			<dx:LayoutGroup Caption="Authorization Data" GroupBoxDecoration="HeadingLine" SettingsItemCaptions-HorizontalAlign="Right"
				ColCount="2">
				<Items>
					<dx:LayoutItem Caption="Email">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td>
											<dx:ASPxTextBox runat="server" ID="eMailTextBox" Width="170px" ClientInstanceName="eMailTextBox"
												AutoCompleteType="Email" OnValidation="eMailTextBox_Validation">
												<ValidationSettings ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom"
													SetFocusOnError="true">
													<RegularExpression ErrorText="Invalid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
													<RequiredField IsRequired="True" ErrorText="The value is required" />
												</ValidationSettings>
												<ClientSideEvents KeyUp="function(s, e) { emailStatusLabel.SetText(''); }" />
											</dx:ASPxTextBox>
										</td>
										<td style="width: 50px; padding-left: 15px;">
											<dx:ASPxImage ID="checkEmailImage" runat="server" ImageUrl="~/Images/checkEmail.png"
												ToolTip="Check Email" Width="26px" ClientInstanceName="checkEmailImage">
												<ClientSideEvents Click="OnCheckEmailImageClick" />
											</dx:ASPxImage>
											<dx:ASPxLoadingPanel ID="loadingPanel" runat="server" ClientInstanceName="loadingPanel"
												ContainerElementID="checkEmailImage" Text="">
											</dx:ASPxLoadingPanel>
										</td>
									</tr>
								</table>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
					<dx:LayoutItem Caption="Check email" ShowCaption="False">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer>
								<dx:ASPxLabel ID="emailStatusLabel" runat="server" Text="" ClientInstanceName="emailStatusLabel"
									Width="200px">
								</dx:ASPxLabel>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
					<dx:LayoutItem Caption="Password">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer>
								<dx:ASPxTextBox ID="passwordTextBox" runat="server" ClientInstanceName="passwordTextBox"
									Password="True" Width="170px" OnValidation="password_Validation">
									<ClientSideEvents Init="ApplyCurrentPasswordStrength" KeyUp="ApplyCurrentPasswordStrength"
										Validation="OnPassValidation" />
									<ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom"
										SetFocusOnError="True">
										<RequiredField ErrorText="The value is required" IsRequired="True" />
									</ValidationSettings>
								</dx:ASPxTextBox>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
					<dx:LayoutItem Caption="Layout Item" RowSpan="2" ShowCaption="False">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer>
								<dx:ASPxRatingControl ID="ratingControl" runat="server" ClientInstanceName="ratingControl"
									ReadOnly="True" Value="0">
								</dx:ASPxRatingControl>
								<dx:ASPxLabel ID="ratingLabel" runat="server" ClientInstanceName="ratingLabel" Text="Password safety">
								</dx:ASPxLabel>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
					<dx:LayoutItem Caption="Confirm password">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer runat="server" SupportsDisabledAttribute="True">
								<dx:ASPxTextBox ID="confirmPasswordTextBox" runat="server" ClientInstanceName="confirmPasswordTextBox"
									Password="True" Width="170px">
									<ClientSideEvents Validation="OnPassValidation" />
									<ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom"
										SetFocusOnError="True">
										<RequiredField ErrorText="The value is required" IsRequired="True" />
									</ValidationSettings>
								</dx:ASPxTextBox>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
				</Items>
				<SettingsItemCaptions HorizontalAlign="Right"></SettingsItemCaptions>
			</dx:LayoutGroup>
			<dx:LayoutGroup Caption="Submit" GroupBoxDecoration="HeadingLine" SettingsItemCaptions-HorizontalAlign="Right"
				ShowCaption="False">
				<Items>
					<dx:LayoutItem Caption="Layout Item" ShowCaption="False">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer runat="server" SupportsDisabledAttribute="True">
								<dx:ASPxCaptcha ID="Captcha" runat="server" Width="100%">
									<ChallengeImage ForegroundColor="#000000">
									</ChallengeImage>
								</dx:ASPxCaptcha>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
					<dx:LayoutItem Caption="SignUp" ShowCaption="False">
						<LayoutItemNestedControlCollection>
							<dx:LayoutItemNestedControlContainer runat="server" SupportsDisabledAttribute="True">
								<div style="float: right">
									<dx:ASPxButton ID="signUp" runat="server" Text="Sign Up" Width="100px" OnClick="signUp_Click">
									</dx:ASPxButton>
								</div>
							</dx:LayoutItemNestedControlContainer>
						</LayoutItemNestedControlCollection>
					</dx:LayoutItem>
				</Items>
				<SettingsItemCaptions HorizontalAlign="Right"></SettingsItemCaptions>
			</dx:LayoutGroup>
		</Items>
	</dx:ASPxFormLayout>
	<dx:ASPxHyperLink ID="hyperLinkUsersPage" runat="server" Text="Check users list"
		NavigateUrl="UsersList.aspx">
	</dx:ASPxHyperLink>
	<asp:AccessDataSource ID="AccessDataSourceCountry" runat="server" DataFile="~/App_Data/WorldCities.mdb"
		SelectCommand="SELECT * FROM [Countries]" />
	<asp:AccessDataSource ID="AccessDataSourceCities" runat="server" DataFile="~/App_Data/WorldCities.mdb"
		SelectCommand="SELECT [City] FROM [Cities] WHERE ([CountryId] = ?)">
		<SelectParameters>
			<asp:Parameter Name="CountryId" Type="Int32" />
		</SelectParameters>
	</asp:AccessDataSource>
	<dx:ASPxCallback ID="CheckEmailCallback" runat="server" ClientInstanceName="CheckEmailCallback"
		OnCallback="CheckEmailCallback_Callback">
		<ClientSideEvents CallbackComplete="CheckEmailCallbackComplete" BeginCallback="function(s, e) { loadingPanel.Show(); }" />
	</dx:ASPxCallback>
	</form>
</body>
</html>

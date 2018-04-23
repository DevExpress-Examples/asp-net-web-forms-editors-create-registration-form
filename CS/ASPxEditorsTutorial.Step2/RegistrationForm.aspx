<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationForm.aspx.cs"
    Inherits="ASPxEditorsTutorial.RegistrationForm" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxFormLayout" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRatingControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
                                <dx:ASPxTextBox ID="firstNameTextBox" runat="server" NullText="First Name..." Width="170px">
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
                                <dx:ASPxTextBox ID="lastNameTextBox" runat="server" NullText="Last Name..." Width="170px">
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
                                    Width="170px">
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
                                <dx:ASPxDateEdit ID="birthDateEdit" runat="server">
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
                                <dx:ASPxTextBox runat="server" ID="eMailTextBox" Width="170px" AutoCompleteType="Email">
                                    <ValidationSettings ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom"
                                        SetFocusOnError="true">
                                        <RegularExpression ErrorText="Invalid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                        <RequiredField IsRequired="True" ErrorText="The value is required" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Check email" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Password">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="passwordTextBox" runat="server" Password="True" Width="170px">
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
                                <dx:ASPxRatingControl ID="ratingControl" runat="server" ReadOnly="True" Value="0">
                                </dx:ASPxRatingControl>
                                <dx:ASPxLabel ID="ratingLabel" runat="server" Text="Password safety">
                                </dx:ASPxLabel>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Confirm password">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server"
                                SupportsDisabledAttribute="True">
                                <dx:ASPxTextBox ID="confirmPasswordTextBox" runat="server" Password="True" Width="170px">
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
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server"
                                SupportsDisabledAttribute="True">
                                <dx:ASPxCaptcha ID="Captcha" runat="server" Width="100%">
                                    <ChallengeImage ForegroundColor="#000000">
                                    </ChallengeImage>
                                </dx:ASPxCaptcha>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="SignUp" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server"
                                SupportsDisabledAttribute="True">
                                <div style="float: right">
                                    <dx:ASPxButton ID="signUp" runat="server" Text="Sign Up" Width="100px">
                                    </dx:ASPxButton>
                                </div>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:AccessDataSource ID="AccessDataSourceCountry" runat="server" DataFile="~/App_Data/WorldCities.mdb"
        SelectCommand="SELECT * FROM [Countries]" />
    </form>
</body>
</html>

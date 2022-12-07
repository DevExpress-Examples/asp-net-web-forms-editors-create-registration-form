Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data.OleDb
Imports System.Configuration

Namespace ASPxEditorsTutorial
	Partial Public Class RegistrationForm
		Inherits System.Web.UI.Page
		Protected Sub cityComboBox_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.CallbackEventArgsBase)
			If String.IsNullOrEmpty(e.Parameter) Then
				Return
			End If
			AccessDataSourceCities.SelectParameters(0).DefaultValue = e.Parameter
			cityComboBox.DataBind()
		End Sub
	End Class
End Namespace
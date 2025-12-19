Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace ASPxEditorsTutorial

    Public Partial Class RegistrationForm
        Inherits Page

        Protected Sub cityComboBox_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.CallbackEventArgsBase)
            If String.IsNullOrEmpty(e.Parameter) Then Return
            AccessDataSourceCities.SelectParameters(0).DefaultValue = e.Parameter
            cityComboBox.DataBind()
        End Sub
    End Class
End Namespace

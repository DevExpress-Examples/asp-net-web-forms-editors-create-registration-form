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
		Protected Sub cityComboBox_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase)
			If String.IsNullOrEmpty(e.Parameter) Then
				Return
			End If
			AccessDataSourceCities.SelectParameters(0).DefaultValue = e.Parameter
			cityComboBox.DataBind()
		End Sub

		Protected Sub signUp_Click(ByVal sender As Object, ByVal e As EventArgs)
			If eMailTextBox.IsValid AndAlso Captcha.IsValid Then
				Using connection As OleDbConnection = GetConnection()
					Dim command As New OleDbCommand(String.Empty, connection)
					command.CommandText = "INSERT INTO [Users] (FirstName, LastName, Gender, BirthDate, Country, City, Email, UserPassword) VALUES (@firstName, @lastName, @gender, @birthDate, @country, @city, @email, @password)"

					command.Parameters.AddWithValue("firstName", firstNameTextBox.Text)
					command.Parameters.AddWithValue("lastName", lastNameTextBox.Text)
					command.Parameters.AddWithValue("gender", genderRadioButtonList.Value)
					command.Parameters.AddWithValue("birthDate", birthDateEdit.Date.ToShortDateString())
					command.Parameters.AddWithValue("country", countryComboBox.Text)
					command.Parameters.AddWithValue("city", cityComboBox.Text)
					command.Parameters.AddWithValue("email", eMailTextBox.Text)
					command.Parameters.AddWithValue("password", passwordTextBox.Text)
					connection.Open()
					command.ExecuteNonQuery()
				End Using
				Response.Redirect("RegidteredPage.aspx")
			End If
		End Sub
		Private Function GetConnection() As OleDbConnection
			Dim connection As New OleDbConnection()
			connection.ConnectionString = ConfigurationManager.ConnectionStrings("UsersConnectionString").ConnectionString
			Return connection
		End Function

		Protected Sub CheckEmailCallback_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs)
			e.Result = GetIsEmailExist(eMailTextBox.Text).ToString()
		End Sub

		Private Function GetIsEmailExist(ByVal email As String) As Boolean
			Using connection As OleDbConnection = GetConnection()
				Dim cmd As New OleDbCommand("SELECT count(*) FROM [Users] WHERE Email = @Email", connection)
				cmd.Parameters.AddWithValue("Email", email)
				connection.Open()
				Dim total As Integer = CInt(Fix(cmd.ExecuteScalar()))
				connection.Close()
				Return total > 0
			End Using
		End Function

		Protected Sub eMailTextBox_Validation(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxEditors.ValidationEventArgs)
			If (Not Page.IsCallback) Then
				e.IsValid = Not GetIsEmailExist(e.Value.ToString())
				e.ErrorText = "Sorry, this e-mail belongs to an existing account"
			End If
		End Sub
	End Class
End Namespace
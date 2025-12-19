Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data.OleDb
Imports System.Configuration
Imports System.Text.RegularExpressions
Imports DevExpress.Web

Namespace ASPxEditorsTutorial

    Public Partial Class RegistrationForm
        Inherits Page

        Protected Sub cityComboBox_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase)
            If String.IsNullOrEmpty(e.Parameter) Then Return
            AccessDataSourceCities.SelectParameters(0).DefaultValue = e.Parameter
            cityComboBox.DataBind()
        End Sub

        Protected Sub signUp_Click(ByVal sender As Object, ByVal e As EventArgs)
            If eMailTextBox.IsValid AndAlso Captcha.IsValid Then
                Using connection As OleDbConnection = GetConnection()
                    Dim command As OleDbCommand = New OleDbCommand(String.Empty, connection)
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

                If ASPxEdit.ValidateEditorsInContainer(registrationFormLayout) Then Response.Redirect("RegisteredPage.aspx")
            End If
        End Sub

        Private Function GetConnection() As OleDbConnection
            Dim connection As OleDbConnection = New OleDbConnection()
            connection.ConnectionString = ConfigurationManager.ConnectionStrings("UsersConnectionString").ConnectionString
            Return connection
        End Function

        Protected Sub CheckEmailCallback_Callback(ByVal source As Object, ByVal e As CallbackEventArgs)
            e.Result = Me.GetIsEmailExist(CStr(eMailTextBox.Text)).ToString()
        End Sub

        Private Function GetIsEmailExist(ByVal email As String) As Boolean
            Using connection As OleDbConnection = GetConnection()
                Dim cmd As OleDbCommand = New OleDbCommand("SELECT count(*) FROM [Users] WHERE Email = @Email", connection)
                cmd.Parameters.AddWithValue("Email", email)
                connection.Open()
                Dim total As Integer = CInt(cmd.ExecuteScalar())
                connection.Close()
                Return total > 0
            End Using
        End Function

        Protected Sub eMailTextBox_Validation(ByVal sender As Object, ByVal e As ValidationEventArgs)
            If Not Page.IsCallback Then
                e.IsValid = e.Value IsNot Nothing
                If Not e.IsValid Then
                    e.ErrorText = "Email is required"
                    Return
                End If

                Dim r As Regex = New Regex("\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*")
                e.IsValid = r.IsMatch(e.Value.ToString())
                If Not e.IsValid Then
                    e.ErrorText = "Email is invalid"
                    Return
                End If

                e.IsValid = Not GetIsEmailExist(e.Value.ToString())
                If Not e.IsValid Then
                    e.ErrorText = "Sorry, this email belongs to an existing account"
                    Return
                End If
            End If
        End Sub

        Protected Sub requiredTextBox_Validation(ByVal sender As Object, ByVal e As ValidationEventArgs)
            e.IsValid = e.Value IsNot Nothing
            If e.IsValid Then e.ErrorText = "This field is required"
        End Sub

        Protected Sub password_Validation(ByVal sender As Object, ByVal e As ValidationEventArgs)
            e.IsValid = e.Value IsNot Nothing
            If Not e.IsValid Then
                e.ErrorText = "Password is required"
                Return
            End If

            Dim password As String = e.Value.ToString()
            e.IsValid = String.Compare(password, confirmPasswordTextBox.Text) = 0
            If Not e.IsValid Then
                e.ErrorText = "The password you entered do not match"
                Return
            End If

            Dim r As Regex = New Regex("[A-Z]+|[a-z]+|\d+|[^\w\d\s]+")
            e.IsValid = r.Matches(password).Count > 1
            If Not e.IsValid Then
                e.ErrorText = "The password is too simple"
                Return
            End If
        End Sub
    End Class
End Namespace


/*
--crear un perfil de correo en la base de datos
execute msdb.dbo.sysmail_add_profile_sp
@profile_name='Notificaciones',
@description='Este perfil es utilizado para mandar notificaciones utilizando Gmail'

--dar acceso a los usuarios a este perfil de correo
execute msdb.dbo.sysmail_add_principalprofile_sp
	@profile_name='Notificaciones',
	@principal_name='public',
	@is_default=1

	--crear una cuenta de correo en la base de datos
execute msdb.dbo.sysmail_add_account_sp
	@account_name='Borjascript',
	@description='Cuenta de email utilizada para enviar notificaciones',
	@email_address='cuenta de correo electrónico del remitente',
	@display_name='Notificaciones Borjascript',
	@mailserver_name='smtp.gmail.com',
	@port=587,
	@enable_ssl=1,
	@username='cuenta de correo electrónico del remitente',
	@password='contraseña de la cuenta de correo electrónico del remitente'

	--agregar la cuenta al perfil Notificaciones
execute msdb.dbo.sysmail_add_profileaccount_sp
	@profile_name='Notificaciones',
	@account_name='Borjascript',
	@sequence_number=1

	select *
from msdb.dbo.sysmail_profile p 
join msdb.dbo.sysmail_profileaccount pa on p.profile_id = pa.profile_id 
join msdb.dbo.sysmail_account a on pa.account_id = a.account_id 
join msdb.dbo.sysmail_server s on a.account_id = s.account_id
*/

declare @BODY varchar(max);
set @BODY='<!DOCTYPE html>
                <html lang="en">
                <head>
                <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width", initial-scale=1.0">
                </head>
                <body>
                <center><img src="https://yt3.ggpht.com/ytc/AKedOLSB2xSNTvOk4Ked_okQZFGL2UR2RGiacPciEqTI6Q=s900-c-k-c0x00ffffff-no-rj" alt="" width="500" height="500"></center>
		<h3>Correo Mandado desde un vídeo de Borjascript</h3>
                </body>
                </html>';

	Exec msdb.dbo.sp_send_dbmail
		@profile_name='Notificaciones',
		@recipients='cuenta de correo electrónico del destinatario',
		--@copy_recipients='correo1@hotmail.com; correo2@outlook.com',
		@body=@BODY,
		@body_format='HTML',
		@subject='Correo del tutorial de Borjascript'

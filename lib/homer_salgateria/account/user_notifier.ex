defmodule HomerSalgateria.Account.UserNotifier do
  import Swoosh.Email

  alias HomerSalgateria.Mailer

  @doc false
  def deliver_reset_password_instructions(user, reset_token) do
    new()
    |> to(user.email)
    |> from({"Recuperador de senhas", "murilosimoes04@hotmail.com"})
    |> subject("Recuperação de senha")
    |> html_body("<h1>Olá #{user.nome}</h1>")
    |> text_body("""
    Olá #{user.nome} Você nos enviou uma solicitação de recuperação de senha!
    acesse este link para redefinir sua senha: <a href="localhost:4000/user/reset_password/#{reset_token}/edit">Clique aqui</a> <br>
    Caso não tiver feito a solicitação, ignore este email.
    """)
    |> Mailer.deliver()

    # por um link na url
  end
end

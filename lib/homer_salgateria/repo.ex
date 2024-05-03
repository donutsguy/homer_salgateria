defmodule HomerSalgateria.Repo do
  use Ecto.Repo,
    otp_app: :homer_salgateria,
    adapter: Ecto.Adapters.Postgres
end

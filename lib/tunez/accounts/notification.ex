defmodule Tunez.Accounts.Notification do
  use Ash.Resource, otp_app: :tunez, domain: Tunez.Accounts, data_layer: AshPostgres.DataLayer

  postgres do
    table "notifications"
    repo Tunez.Repo
  end
end

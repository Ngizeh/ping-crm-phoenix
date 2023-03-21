Faker.start()
alias VuePhoenix.{Repo, Contacts.Contact, Accounts, Accounts.User, Accounts.Account}
alias VuePhoenix.{Organizations.Organization, Organizations}

Accounts.create_account(%{name: "Acme Corporation"})

Repo.insert(%User{
   first_name: "John",
   last_name: "Doe",
   email: "johndoe@gmail.com",
   account_id: List.first(Repo.all(Account)).id,
   owner: true,
   hashed_password: Bcrypt.hash_pwd_salt("password"),
})

for _user <- 1..5 do
   Repo.insert(%User{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      email: Faker.Internet.safe_email(),
      account_id: List.first(Repo.all(Account)).id,
      owner: false,
      hashed_password: Bcrypt.hash_pwd_salt("password"),
   })
end

for _ <- 1..100 do
   Repo.insert(%Organization{
      account_id: List.first(Repo.all(Account)).id,
      name: Faker.Person.name,
      email: Faker.Internet.safe_email,
      phone: Faker.Phone.PtBr.phone,
      address: Faker.Address.street_address,
      city: Faker.Address.city,
      region: Faker.Address.state,
      country: "Africa",
      postal_code: Faker.Address.postcode})
end

for _ <- 1..100 do
   Repo.insert(%Contact{
      account_id: List.first(Repo.all(Account)).id,
      organization_id: Enum.random(Organizations.list_organizations()).id,
      first_name: Faker.Person.name,
      last_name: Faker.Person.name,
      email: Faker.Internet.safe_email,
      postal_code: Faker.Address.postcode,
      phone: Faker.Phone.PtBr.phone,
      address: Faker.Address.street_address,
      city: Faker.Address.city,
      region: Faker.Address.state,
      country: "Africa"
      })
end

IO.puts("\n\n")
IO.puts("Success! Sample data has been added.")


FactoryGirl.create(:customer)
FactoryGirl.create(:user, email: 'a@vendas.com')
FactoryGirl.create(:user, email: 'admin@vendas.com', is_admin: true)

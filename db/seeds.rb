FactoryGirl.create(:customer)
FactoryGirl.create(:user, email: 'a@gmail.com')
FactoryGirl.create(:user, email: 'admin@picadasgalaxias.com', is_admin: true)

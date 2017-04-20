describe "profile page" do
  # Replace with code to make a user variable
  before { visit user_path(user) }

  it { should have_content(user.name) }
  it { should have_title(user.name) }
end
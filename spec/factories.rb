#By using the symbol ':user', we get factory girl to simulate the user model
Factory.define :user do |user|
	user.name					"Sol Kahn"
	user.email					"example@railstutorial.org"
	user.password 				"foobar"
	user.password_confirmation	"foobar"
end

Factory.sequence :email do |n|
	"person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
	micropost.content "Foo bar"
	micropost.association :user
end
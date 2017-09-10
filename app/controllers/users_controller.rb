class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Sergey',
        username: 'ncsergey',
        avatar_url: 'https://s.gravatar.com/avatar/258f9cd3d96f4d5c5acf0ddcde660e92?s=80'
      ),
      User.new(
        id: 2,
        name: 'Max',
        username: 'titan'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Sergey',
      username: 'ncsergey',
      avatar_url: 'https://s.gravatar.com/avatar/258f9cd3d96f4d5c5acf0ddcde660e92?s=80'
    )

    @questions = [
        Question.new(text: "Как дела?", created_at: Date.parse("10.09.2017")),
        Question.new(text: "Что делаешь?", created_at: Date.parse("10.09.2017"))
    ]

    @new_question = Question.new
  end
end

class TodosController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @todos = Todo.all
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = current_user.id
    if @todo.save
      redirect_to todo_path(@todo), notice: '追加に成功しました'
    else
      render :new
    end
  end

  def edit
    @todo = Todo.find(params[:id])
    if @todo.user_id != current_user.id
      redirect_to todos_path, alert: '不正なアクセスです'
    end
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      redirect_to todo_path(@todo), notice: "編集に成功しました。"
    else
      render :edit
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    redirect_to todos_path
  end

  private
  def todo_params
    params.require(:todo).permit(:title, :body)
  end
end

class TodosController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @todos = Todo.all
  end
  
  def myindex
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

  # booleanの:completeをtrue, falseに変更するカラム
  def is_finished 
    @todo = Todo.find(params[:id])
    if @todo.complete == false
      @todo.update(complete: true)
      flash[:notice] = "完了しました。"
      redirect_back(fallback_location: root_path)
    else
      @todo.update(complete: false)
      flash[:notice] = "もとに戻しました。"
      redirect_back(fallback_location: root_path)
    end
  end

  # booleanの:releaseをtrue, falseに変更するカラム
  def is_release 
    @todo = Todo.find(params[:id])
    if @todo.release == false
      @todo.update(release: true)
      redirect_to todos_path, notice: '公開しました'
    else
      @todo.update(release: false)
      redirect_to todos_path, notice: '非公開にしました'
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    flash[:alert] = '削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
  def todo_params
    params.require(:todo).permit(:title3, :body, :release)
  end
end

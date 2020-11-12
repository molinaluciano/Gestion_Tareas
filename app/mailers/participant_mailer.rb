class ParticipantMailer < ApplicationMailer
    def new_task_email
     @user = params[:user]
     @task = params[:task]
    #  metodo mail, el mail al que enviaremos, y el asunto
     mail to: @user.email, subject: 'Tarea Asignada'


    end
end

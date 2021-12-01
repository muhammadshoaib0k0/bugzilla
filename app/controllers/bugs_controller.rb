class BugsController < ApplicationController

	def index
		flash[:danger] = "Bugs have no existance without project"
		redirect_to projects_path
		
	end

	def new
		if can? :create, Bug
			@project_id = params[:project_id]
			if @project_id.present?
				if can_create_bug?(params[:project_id])
					@bug = Bug.new
				else
					flash[:danger] = "Access Denied..."
					redirect_to root_path
				end
			else
				flash[:danger] = "Can't create bug without a project"
				redirect_to projects_path
			end
		else
			flash[:danger] = "Only  Qa can create bug"
			redirect_to root_path
		end
	end

	def create
		if can? :create, Bug
			@project_id = params[:bug][:project_id]
			@bug = Bug.new(bug_params)

			if @bug.save
				redirect_to project_path(@bug.project_id)
			else
				flash[:danger] = "Request failed.."
				render 'new'
			end
		else
			flash[:danger] = "Only Manager or Qa can create bug"
		end
	end

	def show
		if can? :read, Bug
			@bug = Bug.find(params[:id])
			if !can_update_bug(@bug.project_id)
				flash[:dnager] = "Access Denied..."
				redirect_to root_path
			end
		else
			flash[:danger] = "Access Denied..."
			redirect_to request.referer
		end
	end

	def edit
    id = params[:id]
    @bug = Bug.find(id)
	end

	def update
    @bug = Bug.find(params[:id])
    if  params[:assign_to].present?
      @bug.update(assign_to: current_user.id)
      flash[:success] = "Assigned to himself successfully"
    end
		if @bug.update(bug_params)
			flash[:success] = "Updated Sucessfully"
		else
			flash[:danger] = "Update failed.. try again later.."
		end
		redirect_to bug_path(@bug)
	end

	
	

	private

	def bug_params
		params.require(:bug).permit(:title,:description,:assign_to,:status,:bug_type,:project_id,:user_id,:deadline,:img)
	end

end
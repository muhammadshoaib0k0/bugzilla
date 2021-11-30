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
			flash[:danger] = "Only Qa can create bug"
			redirect_to root_path
		end
	end

	def create
		if can? :create, Bug
			@bug = Bug.new(bug_params)
			# @bug.bug_type = params[:my_bug][:bug_type]

			if @bug.save
				redirect_to project_path(@bug.project_id)
			else
				flash[:danger] = "Request failed.."
				render 'new'
			end
		else
			flash[:danger] = "Only Qa can create bug"
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
		if !can_update_bug(@bug.project.id)
			@bug = Bug.find(params[:id])
			flash[:danger] = "Only Project Related Person can Make changes"
			redirect_to root_path
		end
	end

	def update
		@bug = Bug.find(params[:id])
		if @bug.update(bug_params)
			flash[:success] = "Updated Sucessfully"
		else
			flash[:danger] = "Update failed.. try again later.."
		end
		redirect_to bug_path(@bug)
	end

	def bug_status
		@bug = Bug.find(params[:id])
		@bug.update(status: params[:status])
		render json: {success: "ok"}
	end

	def destroy
		if can_update_bug(@bug.project.id)
			if can? :destroy, Bug
				@bug = Bug.find(params[:id])
				if @bug.destroy
					flash[:success] = "Deleted Sucessfully..."
					redirect_to my_bugs_path
				else
					flash[:danger] = "Something went wrong..."
					render 'bug'
				end
			else
				flash[:danger] = "Only Creater of bug can delete his bug..."
				render 'bug'
			end
		end
	end

	private

	def bug_params
		params.require(:bug).permit(:title,:description,:status,:bug_type,:project_id,:user_id,:deadline,:img,:assign_to,:deadline)
	end
end

class PollsController < ApplicationController

	def index
		@polls = Poll.all
	end

	def new
		@poll = Poll.new
	end

	def create
		@poll = Poll.new(poll_params)
		if @poll.save
			flash[:sucess] = 'Poll was created'
			redirect_to polls_path
		else
			render 'new'
		end
	end

	def edit
		@poll = Poll.find_by_id(params[:id])
	end

	def update
		@poll = Poll.find_by_id(params[:id])
		if @poll.update_attributes(poll_params)
			flash[:sucess] = 'Poll was updated!'
			redirect_to polls_path
		else
			render 'edit'
		end
	end

	def destroy
		@poll = Poll.find_by_id(params[:id])
		if @poll.destroy
			flash[:sucess] = 'Poll was destroyed!'
		else
			flash[:warning] = 'Error destroying poll...'
		end
		redirect_to polls_path
	end

	private

	def poll_params
		params.require(:poll).permit(:topic, vote_options_attributes: [:id, :title, :destroy])
	end
	
end

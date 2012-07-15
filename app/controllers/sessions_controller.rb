class SessionsController < ApplicationController
  before_filter :authenticate_user!

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = current_user.upcoming_sessions.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sessions }
    end
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
    @session = current_user.find_session(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @session }
    end
  end

  # GET /sessions/new
  # GET /sessions/new.json
  def new
    @session = current_user.sessions.new start_at: Time.now,
                                         end_at: 1.hour.from_now

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @session }
    end
  end

  # GET /sessions/1/edit
  def edit
    @session = current_user.find_session(params[:id])
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = current_user.add_session(params[:session][:start_at].to_datetime,
                                        params[:session][:duration].to_i.seconds)

    respond_to do |format|
      if @session.save
        format.html { redirect_to @session, notice: 'session was successfully created.' }
        format.json { render json: @session, status: :created, location: @session }
      else
        format.html { render action: "new" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sessions/1
  # PUT /sessions/1.json
  def update
    @session = current_user.find_session(params[:id])

    respond_to do |format|
      update_params = { start_at: params[:session][:start_at].to_datetime,
                        end_at:   params[:session][:start_at].to_datetime + params[:session][:duration].to_i.seconds }
      if @session.update_attributes(update_params)
        format.html { redirect_to @session, notice: 'session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session = current_user.find_session(params[:id])
    @session.destroy

    respond_to do |format|
      format.html { redirect_to sessions_url }
      format.json { head :no_content }
    end
  end
end

class InvitesController < ApplicationController
  
  def sign_up
    new
  end
  
  def recommend
    new
  end
  
  # GET /invites
  # GET /invites.json
  def index
    @invites = Invite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @invites }
    end
  end

  # GET /invites/1
  # GET /invites/1.json
  def show
    @invite = Invite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @invite }
    end
  end

  # GET /invites/new
  # GET /invites/new.json
  def new
    @invite = Invite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @invite }
    end
  end

  # GET /invites/1/edit
  def edit
    @invite = Invite.find(params[:id])
  end

  # POST /invites
  # POST /invites.json
  def create
    @invite = Invite.new(params[:invite])
    @invite.date = Date.today
    if params[:source] == 'recommend'
      @invite.recommendation = true 
    end

    respond_to do |format|
      if @invite.save
        if params[:source] == 'sign_up'
          BetaMailer.sign_up(@invite).deliver
          
          format.html { redirect_to @invite, :notice => "We'll send you an invitation soon!"}
        elsif params[:source] == 'recommend'
          BetaMailer.recommend(@invite).deliver
          
          format.html { redirect_to @invite, :notice => "We've sent an email to #{@invite.email}"}
        end
      else
        format.html { render :action => "new" }
        format.json { render :json => @invite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invites/1
  # PUT /invites/1.json
  def update
    @invite = Invite.find(params[:id])

    respond_to do |format|
      if @invite.update_attributes(params[:invite])
        format.html { redirect_to @invite, :notice => 'Invite was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @invite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invites/1
  # DELETE /invites/1.json
  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    respond_to do |format|
      format.html { redirect_to invites_url }
      format.json { head :ok }
    end
  end
end

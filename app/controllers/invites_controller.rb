class InvitesController < ApplicationController
    
  def sign_up
    @invite = Invite.new
    
    render :action => ab_test(:landing_page_verbage, 'sign_up_1', 'sign_up_2')
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

    @headline = case params[:source]
    when 'recommend'
      "We've sent an email to #{@invite.email}."
    when 'sign_up'
      "We'll send you an invitation soon!"
    when nil
      "Welcome back!"
    end
    
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
    finished(:landing_page_verbage, :reset => false)

    respond_to do |format|
      if @invite.save
        if params[:source] == 'sign_up'
          BetaMailer.sign_up(@invite).deliver
          BetaMailer.notify(@invite).deliver
          
          format.html { redirect_to invite_path(@invite, :source => 'sign_up'), :notice => "We'll send you an invitation soon!"}
        elsif params[:source] == 'recommend'
          BetaMailer.recommend(@invite).deliver
          BetaMailer.notify(@invite).deliver
          
          format.html { redirect_to invite_path(@invite, :source => 'recommend'), :notice => "We've sent an email to #{@invite.email}."}
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

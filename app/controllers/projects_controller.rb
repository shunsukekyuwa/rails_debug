class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @company = Company.find(params[:company_id])
  end

  # GET /projects/1/edit
  def edit
    @company = Company.find(params[:company_id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @company = Company.find(params[:company_id])
    @project = @company.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to company_path(@company), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: company_path(@company)}
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @company = Company.find(params[:company_id])
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to company_path(@company), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: company_path(@company) }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @company = Company.find(params[:company_id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to company_path(@company), notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :company_id)
    end
end

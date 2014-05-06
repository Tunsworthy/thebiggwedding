class PeopleController < ApplicationController
  def index
    @people = Person.order("last_name ASC")
  end

  def list
    @people = Person.order("last_name ASC").to_a
    # Remove bridge and groom
    @people.delete_if { |p| p.name == 'BIGG, Ryan' }
    @people.delete_if { |p| p.name == 'LYNCH, Sharon' }
    # Remove bride's parents
    @people.delete_if { |p| p.name == 'LYNCH, Frank' }
    @people.delete_if { |p| p.name == 'LYNCH, Marilyn' }
    @people.delete_if { |p| p.name == 'GLEESON, Brenda' }
    @people.delete_if { |p| p.name == 'SULLIVAN, John' }
    # Remove groom's parents
    @people.delete_if { |p| p.name == 'BIGG, Karen' }
    @people.delete_if { |p| p.name == 'BIGG, Nigel' }
    @people.delete_if { |p| p.name == 'DE ZEN COOK, Stella' }
    # Remove bridal party
    @people.delete_if { |p| p.name == 'LYNCH, Helen' }
    @people.delete_if { |p| p.name == 'FURUSA, Kerrianne' }

    halfway = @people.length/2
    @people_1 = @people[0..halfway]
    @people_2 = @people[(halfway+1)..-1]


  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      flash[:success] = "Added #{@person.name}!"
      redirect_to new_person_path
    else
      flash[:danger] = "Could not add #{@person.name}."
      render :new
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(person_params)
      flash[:success] = "Updated #{@person.name}'s details!"
      redirect_to session[:return_to] || people_path
      session[:return_to] = nil
    else
      flash[:danger] = "Could not update #{@person.name}."
      render :new
    end  
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    flash[:success] = "Removed #{@person.name}."
    redirect_to people_path
  end

  private

  def person_params
    params.require(:person).permit!
  end
end

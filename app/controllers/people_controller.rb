class PeopleController < ApplicationController
  def index
    @people = Person.order("table_number ASC")
  end

  def list
    @people = Person.order("last_name ASC").to_a
    @couple = []
    @couple << ryan = @people.find { |p| p.name == 'BIGG, Ryan' }
    @couple << sharon = @people.find { |p| p.name == 'BIGG, Sharon' }

    @b_parents = []
    # Remove bride's parents
    @b_parents << frank = @people.find { |p| p.name == 'LYNCH, Frank' }
    @b_parents << marilyn = @people.find { |p| p.name == 'LYNCH, Marilyn' }
    @b_parents << marilyn = @people.find { |p| p.name == 'GLEESON, Brenda' }
    @b_parents << marilyn = @people.find { |p| p.name == 'SULLIVAN, John' }
    # Remove groom's parents

    @g_parents = []
    # Remove bride's parents
    @g_parents << nigel = @people.find { |p| p.name == 'BIGG, Nigel' }
    @g_parents << karen = @people.find { |p| p.name == 'BIGG, Karen' }
    @g_parents << stella = @people.find { |p| p.name == 'DE ZEN COOK, Stella' }

    @b_party = []
    @b_party << helen = @people.find { |p| p.name == 'LYNCH, Helen' }
    @b_party << helen = @people.find { |p| p.name == 'FURUSA, Kerrianne' }
    @b_party << helen = @people.find { |p| p.name == 'BIGG, Scott' }
    @b_party << helen = @people.find { |p| p.name == 'BAKER, Stephen' }

    @people -= @couple
    @people -= @b_parents
    @people -= @g_parents
    @people -= @b_party

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
      redirect_to people_path
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

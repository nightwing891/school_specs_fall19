require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:school_id_1) { 1 }

  let(:valid_attributes) {
    { 
      name: 'Max', 
      student_number: 123, 
      gpa: 3.14,
      school_id: 1
    }
  }

  let(:invalid_attributes) {
    { 
      name: '', 
      student_number: 123, 
      gpa: 3.14,
      school_id: 1
    }
  }

  let(:school) { FactoryBot.create(:school)}
  let(:student) { FactoryBot.create(:student, school_id: school.id)}

    
  describe "GET #index" do  
    it "returns http success" do
      get :index, params: { school_id: school.id }
      expect(response).to be_successful
    end

    it 'render the index template' do
      get :index, params: { school_id: school.id }
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { school_id: school.id, id: student.id }
      expect(response).to be_successful
    end

    it 'render the show template' do
      get :show, params: { school_id: school.id, id: student.id } 
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { school_id: school.id }
      expect(response).to be_successful
    end

    it 'render the new template' do
      get :new, params: { school_id: school.id, id: student.id } 
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { school_id: school.id, id: student.id }
      expect(response).to be_successful
    end

    it 'render the edit template' do
      get :edit, params: { school_id: school.id, id: student.id } 
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new student" do
        expect {
          post :create, params: { student: valid_attributes, school_id: school.id }
        }.to change(Student, :count).by(1)
      end

      it "redirects to the created student" do
        post :create, params: { student: valid_attributes, school_id: school.id }
        expect(response).to redirect_to(Student.last)
      end
    end 

    context "with invalid params" do
      it "does not creates a new student" do
        expect {
          post :create, params: { student: invalid_attributes, school_id: school.id }
        }.to change(Student, :count).by(0)
      end

      it "returns http success" do
        post :create, params: { student: invalid_attributes, school_id: school.id }
        expect(response).to be_successful
      end

      it 'render the new template' do
        post :create, params: { student: invalid_attributes, school_id: school.id }
        expect(response).to render_template(:new)
      end
    end 
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attribute) {
        { gpa: 4.0 }
      }

      it "update the student" do
        put :update, params: { id: student.id, school_id: school.id, student: new_attribute }
        student.reload
        expect(student.gpa).to eq(new_attribute[:gpa])
      end

      it "redirect to the updated student" do
        put :update, params: { id: student.id, school_id: school.id, student: valid_attributes }
        expect(response).to redirect_to(student)
      end
    end

    context "with invalid params" do
      it 'renders the edit template on fail' do
        put :update, params: { school_id: school.id, id: student.id, student: {name: ''}}
        # need to have the rails-controller-testing gem to use render_template
        expect(response).to render_template(:edit)
      end

      it "redirect to the updated student" do
        put :update, params: { id: student.id, school_id: school.id, student: valid_attributes }
        expect(response).to redirect_to(student)
      end
    end

  end

  describe "DELETE #destroy" do
    before (:each) do
      delete :destroy, params: { school_id: school.id, id: student.id }
    end

    it "destroys the requested student" do
      expect(Student.count).to eq(0)
    end

    it "redirects to the student list" do
      expect(response).to redirect_to(students_path)
    end
  end

end

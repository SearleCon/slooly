require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SettingsController do

  # This should return the minimal set of attributes required to create a valid
  # Setting. As you add validations to Setting, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SettingsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all settings as @settings" do
      setting = Setting.create! valid_attributes
      get :index, {}, valid_session
      assigns(:settings).should eq([setting])
    end
  end

  describe "GET show" do
    it "assigns the requested setting as @setting" do
      setting = Setting.create! valid_attributes
      get :show, {:id => setting.to_param}, valid_session
      assigns(:settings).should eq(setting)
    end
  end

  describe "GET new" do
    it "assigns a new setting as @setting" do
      get :new, {}, valid_session
      assigns(:settings).should be_a_new(Setting)
    end
  end

  describe "GET edit" do
    it "assigns the requested setting as @setting" do
      setting = Setting.create! valid_attributes
      get :edit, {:id => setting.to_param}, valid_session
      assigns(:settings).should eq(setting)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Setting" do
        expect {
          post :create, {:settings => valid_attributes}, valid_session
        }.to change(Setting, :count).by(1)
      end

      it "assigns a newly created setting as @setting" do
        post :create, {:settings => valid_attributes}, valid_session
        assigns(:settings).should be_a(Setting)
        assigns(:settings).should be_persisted
      end

      it "redirects to the created setting" do
        post :create, {:settings => valid_attributes}, valid_session
        response.should redirect_to(Setting.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved setting as @setting" do
        # Trigger the behavior that occurs when invalid params are submitted
        Setting.any_instance.stub(:save).and_return(false)
        post :create, {:settings => {}}, valid_session
        assigns(:settings).should be_a_new(Setting)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Setting.any_instance.stub(:save).and_return(false)
        post :create, {:settings => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested setting" do
        setting = Setting.create! valid_attributes
        # Assuming there are no other settings in the database, this
        # specifies that the Setting created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Setting.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => setting.to_param, :settings => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested setting as @setting" do
        setting = Setting.create! valid_attributes
        put :update, {:id => setting.to_param, :settings => valid_attributes}, valid_session
        assigns(:settings).should eq(setting)
      end

      it "redirects to the setting" do
        setting = Setting.create! valid_attributes
        put :update, {:id => setting.to_param, :settings => valid_attributes}, valid_session
        response.should redirect_to(setting)
      end
    end

    describe "with invalid params" do
      it "assigns the setting as @setting" do
        setting = Setting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Setting.any_instance.stub(:save).and_return(false)
        put :update, {:id => setting.to_param, :settings => {}}, valid_session
        assigns(:settings).should eq(setting)
      end

      it "re-renders the 'edit' template" do
        setting = Setting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Setting.any_instance.stub(:save).and_return(false)
        put :update, {:id => setting.to_param, :settings => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested setting" do
      setting = Setting.create! valid_attributes
      expect {
        delete :destroy, {:id => setting.to_param}, valid_session
      }.to change(Setting, :count).by(-1)
    end

    it "redirects to the settings list" do
      setting = Setting.create! valid_attributes
      delete :destroy, {:id => setting.to_param}, valid_session
      response.should redirect_to(settings_url)
    end
  end

end

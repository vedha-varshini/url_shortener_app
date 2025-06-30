require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create(:user, password: 'Password1!') }

  describe "POST #create" do
    it "logs in user with correct credentials" do
      post :create, params: { email: user.email, password: 'Password1!' }
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(shortened_urls_path)
    end

    it "rejects user with wrong password" do
      post :create, params: { email: user.email, password: 'wrongpass' }
      expect(session[:user_id]).to be_nil
      expect(response).to render_template(:new)
    end

    it "rejects login with missing params" do
      post :create, params: { email: '', password: '' }
      expect(session[:user_id]).to be_nil
      expect(response).to render_template(:new)
    end
  end

  describe "DELETE #destroy" do
    it "logs out user" do
      session[:user_id] = user.id
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path)
    end

    it "does nothing if user not logged in" do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path)
    end
  end
end

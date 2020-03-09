require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end
  it 'name、email、password,password_confirmationがある場合、有効である' do
    expect(@user).to be_valid
  end

  describe 'name' do
    it 'ない場合、無効である' do
      @user.name = ''
      expect(@user).to_not be_valid
    end

    it '重複した場合、無効である' do
      user1 = create(:user)
      user2 = build(:user, name: user1.name, email: 'masa@gmail.com', password: '2', password_confirmation: '2')
      expect(user2).to_not be_valid
    end

    it '16文字以下の場合、有効である' do
      @user.name = 'a' * 16
      expect(@user).to be_valid
    end

    it '16文字以上の場合、無効である' do
      @user.name = 'a' * 17
      expect(@user).to_not be_valid
    end

    it 'nameが英数字以外の場合、無効である' do
      @user.name = 'あ'
      expect(@user).to_not be_valid
    end
  end

  describe 'email' do
    it 'ない場合、無効である' do
      @user.email = ''
      expect(@user).to_not be_valid
    end

    it '重複した場合、無効である' do
      user1 = create(:user)
      user2 = build(:user, name: 'new', email: user1.email, password: '2', password_confirmation: '2')
      expect(user2).to_not be_valid
    end

    it '文字数が255以下の場合、有効である' do
      @user.email = "#{'a' * (255 - 12)}@example.com"
      expect(@user).to be_valid
    end
    it '文字数が255以上の場合、無効である' do
      @user.email = "#{'a' * 256}@example.com"
      expect(@user).to_not be_valid
    end

    describe 'emailフォーマット' do
      it '英数字@英数字.英数字が有効である' do
        @user.email = 'user1@email.com'
        expect(@user).to be_valid
      end

      it '英数字以外@英数字.英数字が無効である' do
        @user.email = 'ユーザー@email.com'
        expect(@user).to_not be_valid
      end

      it '英数字@英数字以外.英数字が無効である' do
        @user.email = 'user@eメール.com'
        expect(@user).to_not be_valid
      end

      it '英数字@英数字.英数字が無効である' do
        @user.email = 'user@email.コム'
        expect(@user).to_not be_valid
      end

      it '@が含まれていないと無効である' do
        @user.email = 'useremail.com'
        expect(@user).to_not be_valid
      end
      it '.が含まれていないと無効である' do
        @user.email = 'user@emailcom'
        expect(@user).to_not be_valid
      end
    end
  end

  describe 'password' do
    it 'ない場合、無効である' do
      user = build(:user, password: '', password_confirmation: '')
      expect(user).to_not be_valid
    end

    it 'passwordとpassword_confirmationが一致しない場合、無効である' do
      user = build(:user, password: '1', password_confirmation: '2')
      expect(user).to_not be_valid
    end
  end
end

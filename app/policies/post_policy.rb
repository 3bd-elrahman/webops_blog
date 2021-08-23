class PostPolicy < ApplicationPolicy

    def update?
        author_of_post?
    end

    def destroy?
        author_of_post?
    end


    private

    def author_of_post?
        @user.id == record.user_id
    end

end
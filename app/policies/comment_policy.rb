class CommentPolicy < ApplicationPolicy

    def update?
        author_of_comment?
    end

    def destroy?
        author_of_comment?
    end


    private

    def author_of_comment?
        @user.id == record.user_id
    end


end
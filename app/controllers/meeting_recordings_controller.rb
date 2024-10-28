class MeetingRecordingsController < ApplicationController
    before_action :authenticate_user!
    before_action :validate_pagination_params, only: [ :index ]

    def index
        @meeting_recordings = MeetingRecording.get_allowed_meetings(current_user)
            .distinct
            .order(created_at: :desc)
            .page(params[:page])
            .per(params[:pageSize] || 20)

        respond_to do |format|
            format.html # This will render the index.html.erb view
            format.json { render json: {
            currentPage: @meeting_recordings.current_page,
            pageSize: @meeting_recordings.limit_value,
            totalPages: @meeting_recordings.total_pages,
            totalRecords: @meeting_recordings.total_count,
            recordings: @meeting_recordings.as_json(only: [ :id, :title, :thumbnail_url, :recording_page_url, :created_at ])
            }}
        end
    end

    def show
        @meeting_recording = MeetingRecording.find(params[:id])

        unless @meeting_recording.accessible_to?(current_user)
            render json: { error: "You do not have permission to access these recordings.", code: 403 }, status: :forbidden
            return
        end

        render json: @meeting_recording
    end

    def create
        @meeting_recording = MeetingRecording.new(meeting_recording_params)
        @meeting_recording.creator_user = current_user
        @meeting_recording.creator_role = current_user.role

        if @meeting_recording.save
            render json: @meeting_recording, status: :created
        else
            render json: @meeting_recording.errors, status: :unprocessable_entity
        end
    end

    private

    def meeting_recording_params
        params.require(:meeting_recording).permit(:title, :thumbnail_url, :recording_page_url)
    end
    private

    def validate_pagination_params
        page = params[:page].to_i
        page_size = params[:pageSize].to_i
        if page < 1 || page_size < 1 || limit > 100
            render json: { error: "Invalid pagination parameters." }, status: :bad_request
        end
    end
end

class JournalEntriesController < ApplicationController
  def create
    entry = JournalEntry.new(journal_entry_params)
    if entry.save
      render json: entry, status: :created, message: "Journal successfully created"
    else
      render json: entry.errors, status: unprocessable_entity, message: "Something went wrong"
    end
  end

  def index
    entries = JournalEntry.all
    render json: entries
  end

  def by_date
    entries = JournalEntry.where(date: params[:date])
    render json: entries
  end
end

def journal_entry_params
  params.require(:journal_entry).permit(:title, :body, :date)
end

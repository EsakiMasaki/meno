class Public::NoteProceduresController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]
end

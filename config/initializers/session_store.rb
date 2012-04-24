# Be sure to restart your server when you modify this file.

PrisonerDilemma::Application.config.session_store :cookie_store, key: '_PrisonerDilemma_session', :expire_after => 1.day

##I added the expire_after 1.day thing...if i get rid of it, I lose my session whenever I exit Firefox

##experiment
#cookies[:_PrisonerDilemma_session][:expires] = 1.day.from_now


#looks good to me

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# PrisonerDilemma::Application.config.session_store :active_record_store

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :twitter, 'cSw2k3ueuH0L1bkcQkEAQ', 'J1wmhkFjfVyrIRas6rawECeBh5P4N7lnwSw2QVVrw'
	provider :facebook, '72294482682', '97d67c3996d8e01dfaa5917b8f45d951'
end
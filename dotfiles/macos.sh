# Disable font smoothing, more information - https://tonsky.me/blog/monitors/
# To check current value use `defaults -currentHost read -g | grep 'AppleFontSmoothing'`
defaults -currentHost write -g AppleFontSmoothing -int 0

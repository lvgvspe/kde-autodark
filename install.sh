chmod +x .autodark.sh
sudo cp autodark.service /etc/systemd/user
sudo cp resumedark.service /etc/systemd/user
sudo cp suspend@.service /etc/systemd/system
sudo systemctl daemon-reload && sudo systemctl enable suspend@$(whoami)
sudo cp suspend.target ~/.config/user
systemctl --user daemon-reload
systemctl --user enable autodark
systemctl --user enable resumedark
systemctl --user start autodark
systemctl --user start resumedark
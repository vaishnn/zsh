[ -f "$HOME/.config/zsh/exports.zsh" ] && source "$HOME/.config/zsh/exports.zsh"
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"
[ -f "$HOME/.config/zsh/oh-my-zsh-setup.zsh" ] && source "$HOME/.config/zsh/oh-my-zsh-setup.zsh"

# for loading functions
for file in $HOME/.config/zsh/functions/*.zsh; do
  source "$file"
done

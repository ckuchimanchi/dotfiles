source .antigen.zsh
for file in .zshrc.d/*; do
  source "$file"
done

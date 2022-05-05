#!/bin/zsh

# Usage: ./install.zsh

# Setting colored output
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo 'Available themes ...'
    echo '[1] - Fancy '
    echo '[2] - Light '
    read  'choice?Choose theme or cancel script: [1] [2] [E]xit: ' 
    case "$choice" in
        [1]* ) echo -e "Selected $choice for Fancy" ; theme_name=luceast;;
        [2]* ) echo -e "Selected $choice for Light" ; theme_name=luceast-simple;; 
        [Ee]* ) echo "exited by user" && exit 0;;
        * ) echo "404 - Option not found" && exit 0;;
    esac
    
# echo $theme_name && exit
theme_file=$theme_name.zsh-theme
oh_my_zsh_themes_folder=${HOME}/.oh-my-zsh/themes

if [ ! -d $oh_my_zsh_themes_folder ]; then
    echo "${RED}ERROR: $oh_my_zsh_themes_folder not found.${NC}"
    exit 1
fi

cp $theme_file $oh_my_zsh_themes_folder

if [ -f $oh_my_zsh_themes_folder/$theme_file ]; then
    echo "${GREEN}Installed theme${NC}"
else
    echo "${RED}ERROR: Couldn't copy to $oh_my_zsh_themes_folder${NC}"
    exit 1
fi

sed -i -e 's/ZSH_THEME=".*"/ZSH_THEME="'$theme_name'"/' ${HOME}/.zshrc

if grep -Fxq 'ZSH_THEME="'$theme_name'"' ${HOME}/.zshrc ; then 
    echo "${GREEN}Theme set on .zshrc${NC}"
    echo "Write ${YELLOW}'source ~/.zshrc'${NC} to reload your Z Shell"
    source ${HOME}/.zshrc
else
    echo "${RED}ERROR: Theme not set on .zshrc${NC}"
    exit 1
fi
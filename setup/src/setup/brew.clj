(ns setup.brew
  (:require
   [babashka.process :refer [shell]]))

(def *brew*
  {:taps ["borkdude/brew"
          "candid82/brew"
          "clojure/tools"
          "coursier/formulas"
          "d12frosted/emacs-plus"
          "arthurk/virt-manager"
          "bell-sw/liberica"
          "epk/epk"
          "felixkratz/formulae"
          "homebrew/bundle"
          "homebrew/cask"
          "homebrew/cask-fonts"
          "homebrew/core"
          "homebrew/services"
          "koekeishiya/formulae"
          "minacle/chntpw"
          "railwaycat/emacsmacport"
          "sidneys/homebrew"
          "vldmrkl/formulae"]

   :core-brews [
                ; Software and package management tools
                "git"
                "docker"
                "node"
                "pyenv"
                "nvm"
                "leiningen"
                "maven"
                "gh"

                ; Core CLI tools
                "nvim"
                "http-server"
                "htop"
                "ranger"
                "tree"
                "fzf"
                "tldr" ; very useful!
                "tmux"
                "wget"
                "dos2unix"
                "httrack"
                "neofetch"
                "pngpaste"

                ; Languages and environments thereof
                "clojure/tools/clojure"
                "borkdude/brew/babashka"
                "coursier/formulas/coursier"
                "sqlite"

                ; Window management and keybindings
                 "koekeishiya/formulae/yabai"
                 "koekeishiya/formulae/skhd"]

   :core-casks ["kitty"
                "firefox"
                "slack"
                "zoom"
                "karabiner-elements"]

   :zsh-brews ["zsh-autocomplete"
               "zsh-syntax-highlighting"
               "zsh-history-substring-search"]

   ; Extra developer brews that are not immediately necessary,
   ; keep an eye on these
   :watchlist-brews ["groovy"
                     "kotlin"
                     "kafka"
                     "postgresql"
                     "sqlmap"
                     "ninja"]

   :font-casks ["font-3270-nerd-font"
                "font-agave-nerd-font"
                "font-anonymice-nerd-font"
                "font-arimo-nerd-font"
                "font-aurulent-sans-mono-nerd-font"
                "font-bigblue-terminal-nerd-font"
                "font-bitstream-vera-sans-mono-nerd-font"
                "font-blex-mono-nerd-font"
                "font-cousine-nerd-font"
                "font-daddy-time-mono-nerd-font"
                "font-dejavu-sans-mono-nerd-font"
                "font-droid-sans-mono-nerd-font"
                "font-fantasque-sans-mono-nerd-font"
                "font-fira-code-nerd-font"
                "font-fira-mono-nerd-font"
                "font-fontawesome"
                "font-go-mono-nerd-font"
                "font-gohufont-nerd-font"
                "font-hack-nerd-font"
                "font-hasklug-nerd-font"
                "font-heavy-data-nerd-font"
                "font-hurmit-nerd-font"
                "font-im-writing-nerd-font"
                "font-inconsolata-go-nerd-font"
                "font-inconsolata-lgc-nerd-font"
                "font-inconsolata-nerd-font"
                "font-iosevka-nerd-font"
                "font-lekton-nerd-font"
                "font-liberation-nerd-font"
                "font-meslo-lg-nerd-font"
                "font-monofur-nerd-font"
                "font-monoid-nerd-font"
                "font-mononoki-nerd-font"
                "font-mplus-nerd-font"
                "font-overpass-nerd-font"
                "font-profont-nerd-font"
                "font-proggy-clean-tt-nerd-font"
                "font-roboto-mono-nerd-font"
                "font-sauce-code-pro-nerd-font"
                "font-sf-mono-nerd-font"
                "font-shure-tech-mono-nerd-font"
                "font-space-mono-nerd-font"
                "font-terminess-ttf-nerd-font"
                "font-tinos-nerd-font"
                "font-ubuntu"
                "font-ubuntu-mono-nerd-font"
                "font-ubuntu-nerd-font"
                "font-victor-mono-nerd-font"]})

(defn install [args]
  (apply shell (concat ["brew install"] args)))

(defn install-cask [args]
  (apply shell (concat ["brew install" "--cask"] args)))

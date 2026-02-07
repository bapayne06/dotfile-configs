(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups")))
 '(browse-url-firefox-program "floorp")
 '(byte-compile-warnings '(unresolved noruntime suspicious))
 '(c-default-style
   '((c-mode . "c")
	 (c++-mode . "cc")
	 (csharp-mode . "csharp")
	 (other . "gnu")))
 '(completion-ignored-extensions
   '(".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".dfsl" ".pfsl" ".d64fsl" ".p64fsl" ".lx64fsl" ".lx32fsl" ".dx64fsl" ".dx32fsl" ".fx64fsl" ".fx32fsl" ".sx64fsl" ".sx32fsl" ".wx64fsl" ".wx32fsl" ".fasl" ".ufsl" ".fsl" ".dxl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo" ".txt"))
 '(cua-mode t)
 '(current-language-environment "UTF-8")
 '(custom-buffer-indent 4)
 '(custom-enabled-themes '(doom-Iosvkem))
 '(custom-safe-themes
   '("f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd" "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19" "13096a9a6e75c7330c1bc500f30a8f4407bd618431c94aeab55c9855731a95e1" "b754d3a03c34cfba9ad7991380d26984ebd0761925773530e24d8dd8b6894738" "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1" "d12b1d9b0498280f60e5ec92e5ecec4b5db5370d05e787bc7cc49eae6fb07bc0" "9d5124bef86c2348d7d4774ca384ae7b6027ff7f6eb3c401378e298ce605f83a" "6963de2ec3f8313bb95505f96bf0cf2025e7b07cefdb93e3d2e348720d401425" "7de64ff2bb2f94d7679a7e9019e23c3bf1a6a04ba54341c36e7cf2d2e56e2bcc" "456697e914823ee45365b843c89fbc79191fdbaff471b29aad9dcbe0ee1d5641" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" "7771c8496c10162220af0ca7b7e61459cb42d18c35ce272a63461c0fc1336015" "e8bd9bbf6506afca133125b0be48b1f033b1c8647c628652ab7a2fe065c10ef0" "921f165deb8030167d44eaa82e85fcef0254b212439b550a9b6c924f281b5695" "720838034f1dd3b3da66f6bd4d053ee67c93a747b219d1c546c41c4e425daf93" "f053f92735d6d238461da8512b9c071a5ce3b9d972501f7a5e6682a90bf29725" "70c88c01b0b5fde9ecf3bb23d542acba45bb4c5ae0c1330b965def2b6ce6fac3" "c07f072a88bed384e51833e09948a8ab7ca88ad0e8b5352334de6d80e502da8c" "f6ea954a9544b0174a876d195387f444da441535ee88c7fb0fc346af08b0d228" "19d62171e83f2d4d6f7c31fc0a6f437e8cec4543234f0548bad5d49be8e344cd" default))
 '(default-frame-alist '((fullscreen . fullboth)))
 '(delete-old-versions t)
 '(dired-kept-versions 1)
 '(display-line-numbers t)
 '(display-time-format "%X %Z")
 '(display-time-mode t)
 '(font-use-system-font t)
 '(global-semantic-decoration-mode t)
 '(global-semantic-idle-local-symbol-highlight-mode t nil (semantic/idle))
 '(global-semantic-show-parser-state-mode t)
 '(grep-command "rg")
 '(grep-scroll-output t)
 '(grep-search-path '(nil "~/" "/"))
 '(hexl-iso "-iso")
 '(hexl-options "-iso")
 '(inhibit-startup-screen t)
 '(iso-ascii-convenient nil)
 '(ispell-check-comments nil)
 '(kept-old-versions 0)
 '(large-file-warning-threshold 15000000000)
 '(latin1-display t nil (latin1-disp))
 '(latin1-display-mnemonic t)
 '(lazy-highlight-initial-delay 0.5)
 '(lazy-highlight-interval 1)
 '(out-of-memory-warning-percentage 30)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
	 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
	 ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(doom-themes lsp-ui lsp-mode tree-sitter-langs tree-sitter ac-c-headers async aggressive-indent adjust-parens company-ebdb company-statistics company-math bash-completion))
 '(python-shell-virtualenv-root "~/venv")
 '(semantic-mode t)
 '(semantic-which-function-use-color t)
 '(senator-highlight-found t)
 '(show-trailing-whitespace t)
 '(tab-width 4)
 '(user-mail-address "bpayne88@protonmail.com")
 '(what-cursor-show-names t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack Nerd Font" :foundry "SRC" :slant normal :weight regular :height 98 :width normal)))))

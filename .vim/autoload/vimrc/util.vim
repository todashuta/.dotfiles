vim9script

export def CheckEfmLangserverInstalled(): void
  if empty(lsp_settings#exec_path('efm-langserver'))
    echowindow 'Please run :LspInstallServer efm-langserver'
  endif
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:

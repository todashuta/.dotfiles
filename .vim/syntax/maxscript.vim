syn region maxscriptString start=/"/ end=/"/ skip=/\\\\\|\\"/

syn region maxscriptComment start=/\/\*/ end=/\*\//
syn match maxscriptComment /--.*/
syn sync ccomment maxscriptComment
set comments+=:--

hi def link maxscriptString  String
hi def link maxscriptComment Comment

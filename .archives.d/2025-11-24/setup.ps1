if ($args.length -eq 0) {
	Write-Host "Help:"
	Write-Host "  setup.bat all"
	Write-Host "  setup.bat vim"
	return
}
if ($args.length -gt 1) {
	Write-Host "Too many arguments: $args"
	return
}

$a = $args[0]
switch ($a) {
	"all" {
		Write-Host "setup all: Not Implemented Yet"
		break
	}
	"vim" {
		Write-Host "setup vim: Not Implemented Yet"
		break
	}
	default {
		Write-Host "Unknown option: $a"
	}
}

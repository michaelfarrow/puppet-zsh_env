class zsh_env {

	define setup_zsh() {

		if $name == 'root' {
			if $osname == 'Darwin' {
				$home = "var/${name}"
			} else {
				$home = "/${name}"
			}
		} else {
			if $osname == 'Darwin' {
				$home = "/Users/${name}"
			} else {
				$home = "/home/${name}"
			}
		}

		Exec <| title == "ohmyzsh::git clone ${name}" |> {
			cwd => $home,
		}

		ohmyzsh::install { "${name}": }

		file { "custom_zsh_theme for ${name}":
			ensure => present,
			path    => "${home}/.oh-my-zsh/themes/custom.zsh-theme",
			source  => 'puppet:///modules/zsh_env/custom.zsh-theme',
			require => Exec["ohmyzsh::git clone ${name}"],
		}

		ohmyzsh::theme { "${name}":
			theme   => 'custom',
			require => File["custom_zsh_theme for ${name}"],
		}

	}

	$users_split = split($users, "\n")

	class { 'ohmyzsh': } -> setup_zsh { $users_split: }

}
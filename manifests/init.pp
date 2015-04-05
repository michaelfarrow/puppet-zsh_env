class zsh_env {

	define setup_zsh() {

		if $name == 'root' {
			if $::osname == 'Darwin' {
				$home = "var/${name}"
				$install = false
			} else {
				$home = "/${name}"
				$install = true
			}
		} else {
			if $::osname == 'Darwin' {
				$home = "/Users/${name}"
			} else {
				$home = "/home/${name}"
			}
			$install = true
		}

		if $install == true {

			Exec <| title == "ohmyzsh::git clone ${name}" |> {
				command => "git clone https://github.com/robbyrussell/oh-my-zsh.git ${home}/.oh-my-zsh",
				cwd => $home,
			}

			ohmyzsh::install { "${name}":
				set_sh => true,
			}

			ohmyzsh::plugins { "${name}": plugins => 'git git-extras common-aliases' }

			file_line { "${name}-custom-functions":
				path    => "${home}/.zshrc",
				line    => 'source $HOME/.zshrc_custom',
				require => Ohmyzsh::Install[$name],
			}

			file { "custom .zshrc for ${name}":
				ensure => present,
				path    => "${home}/.zshrc_custom",
				source  => 'puppet:///modules/zsh_env/zshrc_custom',
				require => Exec["ohmyzsh::git clone ${name}"],
			}

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

	}

	$users_split = split($users, "\n")

	class { 'ohmyzsh': } -> setup_zsh { $users_split: }

}
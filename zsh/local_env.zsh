# """"""""""""""""""""""""""""""""""""""""""
# PATH
# """"""""""""""""""""""""""""""""""""""""""
# MySQL
export PATH=/usr/local/mysql/bin/:$PATH
# openssl
export PATH=/usr/local/opt/openssl@1.1/bin:$PATH
# User
export PATH=$HOME/x/apps/nvim/bin/:$HOME/x/code/go/bin:$PATH

export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# """"""""""""""""""""""""""""""""""""""""""
# Golang
# """"""""""""""""""""""""""""""""""""""""""
export GOPATH=$HOME/x/code/go

# """"""""""""""""""""""""""""""""""""""""""
# Python virtualenv
# """"""""""""""""""""""""""""""""""""""""""
export WORKON_HOME=$HOME/.wonenvs
source /usr/local/bin/virtualenvwrapper.sh

# """"""""""""""""""""""""""""""""""""""""""
# Java openjdk
# """"""""""""""""""""""""""""""""""""""""""
# export PATH="/usr/local/opt/openjdk/bin:$PATH"
# export CPPFLAGS="-I/usr/local/opt/openjdk/include"
#
export JAVA_HOME=$(/usr/libexec/java_home)

# """"""""""""""""""""""""""""""""""""""""""
# Zhihu
# """"""""""""""""""""""""""""""""""""""""""
export MYSQL_PASSWORD=HELLOzh123
export GOPROXY=https://goproxy.in.zhihu.com,direct
export GOPRIVATE=git.in.zhihu.com

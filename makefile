############################################################################
#
#   Copyright (c) 2015 Mark Charlebois. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
# 3. The names of the contributors may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE
# BY THIS LICENSE.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT
# AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED, INCLUDING, 
# BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF AND FITNESS FOR A 
# PARTICULAR PURPOSE ARE. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
# EXEMPLARY, OR DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# OF GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
############################################################################

foo:
	echo "Assembling Image..."

oe: foo
	@cd oe && make

debian: foo
	@cd debian && make debian

debian-lxde: foo
	@cd debian && make debian-lxde

#opensuse: foo
#	@cd opensuse && make

#ubuntu: foo
#	@cd ubuntu && make

Paperclip.interpolates :hashed_path do |attachment, style|
  secret = '\\<C]:3wpKOsX+ra.Prc}(Mr8nvltxT@W|5t>-JTn9XwixSG,iiCuz-lN@;de#QYZq\sHL*xMW;cNRz9DKLA5/^R(4G#5`qK|x6.5IcR-u3e?El,.?z@T_ix%NEr[zsK
R6XuaITC@dyidN&Rro}RGL&Q}@_!l}>>8Vb)b1*x)r!`+A%+c3&kVEW[nC![N@UJ2\q*O;SFR\3.1*TP8M##0:9<(O=`)rD1{onr~xo2+0Gq?fm&(mW,Aw)_<?QHF*s5
qhQYTs{YCVy5|ZI\3r8ErYv[axb=<;sN;VTOt~dt(I\Te\mqIGx]<u0XtzG7@wdCyK:rVJq93%:!JDGQK,p_V!Ls-In?kBsg}QF2,C4{w8r+MJ0DpOdVhyTBD*4j[5%D
5,M_v/^KF#VI1%jdQ>6n#*_iNi~E\?Ik6:$I@}U3U>huz>nKvvH32fP$R7a-t)|UytRlbKMHwYhJ&J<5ci&E\t_1TefsH$pc`1o1~lS.^M)bb$1TTfvcLu$1JmvXbrx)
}9M=sUq,1>o(g(!q>6$5z>1@?~c)4gD80I:N#UPIx\sq1umKJez}n]^Bi:u1::f3^OIyGEXULDHQk4hj#Qv$9+>4#\(IS^:kgNElw85>]KSr<L~}L5f<Ee!/mea`B#:(
U[T!~)a7P2]Y~vE4-BHFMhnk3k|kN{9i>-tlA6aPpv2cm=s\v>+<ZVh]itd6NS|\H#4{J}sh;T@x+86Rgk47@C+CEGytDQ#k4J@?[@6czA?p7iRPDN@#6_:JDc\~jHe3
						'
  hash = Digest::MD5.hexdigest("--#{attachment.class.name}--#{attachment.instance.id}--#{secret}--")
  hash_path = ''
  6.times { hash_path += '/' + hash.slice!(0..2) }
  hash_path[1..24]
end
local i=[[
�local c,m,p,u,x,y,z,A,B,C,D,H,L,M,N,O,R,S,T,U,V,W,X,_,aa,ba,ca,da=selectedObj�X,componen�duter,"filesystem"," �Tproxy�YfsBack",50�Sower�Rill��Qin�Vnet",16�Pr�SColo�Rtex�^getBootAddress�Ukey_up�WullSigna�Tinser�_table,string,"s�}Ugroundb�
��Smeta�Q"P�U anyth�Y else to b�W normall(�YTAB or DEL�Pe2f the BIOS options menu	X/init.lua}SForemYlocal
Z=2
�Wq=621101�Ys=12910509�RQ=0�RF=5�Rv=3�Uea=nil�Ti=m[y _(m.list"gpu"())�PP�Ueeprom�PY
�R(H)�Sl={}NPE�Pa�Tv=v+F>Sfunch
K(e)return
80-(#e/2)end�_l:new(e,h,g,f,jePb�X_(b,self)�X.__index=�^
b.x=K(g)b.y=h�Utext=g�Sfx=#�U+Q
b[M P=�Q[N U=j
a[e R=b
�PrsVer()i[W P(���Qda�PN�PC�Q.xpQ.y�Ufx,F,xNPeg_.y+math.floor(FTi.set�U+Q/2,e�MP)tRunR
rPq��lAll()for
e,h
in
pairs(a)do
h	��T`AdjacentObjects(�_,g,f)if
e
then
Sup=e��Ph	�Udown=h�Pg	�Uleft=g�Pf	�Uright=�oPH�Pl�Q(e{Q[M Q=s�PN V=q
else�Pq�PsIQ:r	TE:new_)local
g={}_(g,P)R__i�Qx=\
g.attached=e�YmainObjectUreturn��Tl:unR|XAll()for
�Y
in
pairs(��T)do
hLPc~	�Z
c:setHighl�Ut(true"Rp[O P=Q()hXP.getData�Rp[X	�Se)P.���Tlocal8Ue(h,g)�l=h.open(g,"r")if
not
f
then
�Snil
�Rj=D�Speat�Pb�qread(f,math.huge)j=j..(b
or
D)unt��Zb
h.close(f3Pj	�\Qh(_Rm[y �$e�S,ca)��X"/OS.lua"�QloXYj,"=init")�Qg(�R{}fAbj,b
in
m.list(u)doPdgPjgSd.ex�Qs(���LRU[T aPj�
;Pf	=xPf�PjRp[X�lPf�PO Q()�Sb=h(�*mRnot��&Q[1 P)�Qb(	��Rj(b)Ub==200~Xc.up~=nillYc:setHighl�Yt(false)c=��Strue��P8	�Sdown#��$�P3	ISleft#G�$EP5	EPr#D�#CP8XX.onTouch("blocal
function
b()�Yd=D
repeat�Xk,r,o=p[S �^t=V.char(o)i[C Z(1,A,L,1,x)*Uk==R
aTV.mat�Yt,"[%w%p%u Q")Zd=d..t
or
Du
�Ro==KPd�Tsub(d�S#d-1$Qi.�Vd)until�Q13MRtur�$p:new(u,24,"Filesystem Menu",q,s)�TB,a[u `.y+v,"Power Down�[function
a.p�U.onTou1W)p.shutd�P(n�PH�PB�fBoot From The Internet�Pi��TlocaldY.request(b())if
not$Wthen
i[C `(1,A,1,L,x)i.set�d"Invalid IP")return
`�Yk=D
repeat�Rr=d�had(999)k=k..(r
or
D)unti�Q=n�Vd.closedSr=lo�Wk,"=init�Q()�Sd=24�Pg�h{}l:new(z,d,"Back",q,s)f�To,t
i)Ypairs(k)doNTn=m[y [(t).getLabel|�Pn�Pn�Ra[n d.onTouch=function()f�^w
if
o~=1
thenUaJ=a[m.proxy(k[o-1 
� nw=J
J:setAdjacentObjects(J.up,��S==#k�r�Y�Pz��Tw)U[T Q(r�Ud=d+v
7���R.y=�Pu�Rnil_PB�PBqPu <PH�PHN�Pz1[m.proxy(k[#k [).getLabel() `)local
o=E:new({�PB�P}'Pu�Pt�(yfunction
a.filesystem.onTouch()t:render()�P

�TsBack�Po�q�Un()i[C Y(1,1,L,A,x	�Qwh�W
true
do�Rw,I�TG=p[S �_f
w==R
then
j(Gu�Ri[W Q(q�Qda Q(s�_i.set(K(ba),24,��Pa�Q6,��PZ�WG==15
or�R211�5Uelse
f]]local j,o,s,l,p,f=1,""while j<=#i do
l,s=i:byte(j,j+1)s=s or 0l=l+(l>13 and 1 or 2)-(l>93 and 1 or 0)s=s-(s>13 and 1 or 0)-(s>93 and 1 or 0)if l>80then
l=l-80o=o..i:sub(j+1,j+l)j=j+l
elseif l>2 then
f=#o+(s-253)while l>0 do
p=o:sub(f,f+l-1)o=o..p
f=f+#p
l=l-#p
end
j=j+1
else
o=o.."]"end
j=j+1
end
return assert(load(o))(...)
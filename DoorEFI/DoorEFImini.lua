local i = [[
local c,m,p,u,x,y,z,A,B,C,D,H,L,M,N,Q,R,S,T,U,V,W,Z,_,aa,ba,ca=selectedObjψX,componenφauter,"filesystem"σPlωXproxy",50υSowerζTsBackέP ΩΦQinΒRnetΛWtextColoΩPr‘τ^getBootAddressΆPsο»Uground’\key_up",tableαΠXpullSignalUstringRserPP«U anythηY else to bW normall<ΩYTAB or DELάPeCf the BIOS options menuX/init.luaMSForeM>SmetaOY
local
Y=2φWr=621101ηYs=12910509ΦRO=0ΜRG=5ΒRv=3ΈUda=nil«Ti=m[y _(m.list"gpu"())PPεUeepromβPX
ΗR(H)ΙSk={}NPEφPaμTv=v+G4pfunction
J(e)return
80-(#e/2)endί_k:new(e,h,g,f,jePbYca(b,self)ϋX.__index=ξ^
b.x=J(g)b.y=hςUtext=gιSfx=#ρU+O
b[M P=ΣQ[L U=j
a[e R=b
‚PrrVer()i[Q P(’ΜσQbaςPLςPxεQ.xpQ.yωUfx,G,CMPeg_.y+math.floor(GTi.setΒU+O/2,eΌMP)tRunR
rPr†ΑlAll()for
e,h
in
pairs(a)do
h	ƒT`AdjacentObjects(Ό_,g,f)if
e
then
Sup=eΒθPh	θUdown=hζPg	ΞUleft=gΜPf	΄Uright= oPHβPlήQ(e{Q[M Q=sφPL P=RlseηPrηPsIQ:r	TE:new`)local
g={}ca(g,P)R__iΗQx=\
g.attached=eσYmainObjectUreturn‡Tk:unR{VAll()foI[,h
in
pairs(’΅T)do
hKPc~	Z
c:setHighlόUt(true!Rp[N P=Q()hXP.getData±Rp[T	ΫSe)P.³α»Tlocal8Ue(h,g)λl=h.open(g,"r")if
not
f
then
’Snil
ΉRj=DηSpeat¨Pb½qread(f,math.huge)j=j..(b
or
D)unt½§Zb
h.close(f3Pj	¤\Qh(_Rm[y ρ$e¨S,aa)φX"/OS.lua"”QloXYj,"=init")‡Qg(R{}fAbj,b
in
m.list(u)doPdgPjgSd.exαQs(„ρ€LRS[W aPj‰
;Pf	=xPf§PjRp[T–lPfκPN Q()¤Sb=h(ρ*mRnotΪΒ&Q[1 P)ΧQb(	«ƒRj(b)Ub==200~Xc.up~=nillYc:setHighlόYt(false)c=ΪδStrueά§P8	§Sdown#¥Ψ$£P3	ISleft#GΨ$EP5	EPr#DΧ#CP8XX.onTouch("blocal
function
b()ξYd=D
repeatέXl,q,o=p[U έ^t=V.char(o)i[x \(1,z,160,1,C)(Ul==R
aTV.matYt,"[%w%p%u Q")Zd=d..t
or
Ds
ΚRo==IPdTsub(d¦S#d-1"Qi.	Vd)untilΟQ13KRtur¦"qk:new(u,24,"Filesystem Menu",r,s)ίTA,a[u `.y+v,"Power Downή[function
a.pεU.onTou1W)p.shutdΦP(n“PH΄PA΄fBoot From The Internet¨Piη¥TlocaldX.request(b())if
not$Wthen
i[x U(1,z,1ώVC)i.setπd"Invalid IP")return
`«Yl=D
repeatοRq=dhad(999)l=l..(q
or
D)untiΰQ=nωVd.closedSq=loΜ\l,"=init")q()›Sd=24PgΜh{}k:new(B,d,"Back",r,s)f‘To,t
i)Ypairs(l)doNTn=m[y ^(t).getLabel()ΊPnΊPnΏRa[n d.onTouch=function()fΚ^w
if
o~=1
thenUaK=a[m.proxy(l[o-1
 nw=K
K:setAdjacentObjects(K.up,‰§S==#l¦rΜYΙPBΙΧTw)S[W Q(qUd=d+v
7κΐ»R.y=»Pu’Rnil_PAΦPAqPu <PH΄PHNΑPB1[m.proxy(l[#l [).getLabel() `)local
o=E:new({•PAP}'PuάPtά(yfunction
a.filesystem.onTouch()t:render()ωP

ΣTsBackΧPoΧq¤Un()i[x R(1,ώU60,z,C	ΟQwh‡W
true
doΕRw,IώTF=p[U Γ_f
w==R
then
j(FsόRi[Q Q(rQba Q(s—_i.set(J(_),24,_πPZπS6,Z)PYWF==15
orχR211ƒ5Uelse
f]]local j, o, s, l, p, f = 1, ""while j <= #i do
  l, s = i:byte(j, j + 1)s = s or 0l = l + (l > 13 and 1 or 2) - (l > 93 and 1 or 0)s = s - (s > 13 and 1 or 0) - (s > 93 and 1 or 0)if l > 80then
  l = l - 80o = o..i:sub(j + 1, j + l)j = j + l
elseif l > 2 then
  f = #o + (s - 253)while l > 0 do
    p = o:sub(f, f + l - 1)o = o..p
    f = f + #p
    l = l - #p
  end
  j = j + 1
else
  o = o.."]"end
  j = j + 1
end
return assert(load(o))(...)

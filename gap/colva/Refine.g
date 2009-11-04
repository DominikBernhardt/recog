SolvePcWord := function(rri,g)
 local T,PtoT;
 T := GroupWithMemory(GroupWithGenerators(List(AsList(Pcgs(Grp(rri))),x->())));
 PtoT := GroupHomomorphismByImages(Grp(rri),T,AsList(Pcgs(Grp(rri))),GeneratorsOfGroup(T)); 
  
 return SLPOfElm(ImageElm(PtoT,g));
end;




InsertSubTree := function(ri,rifac,maps)
# insert a subtree in ri where maps is a sequence of normal series maps for Grp(rifacs)
 local kerfac,phi,Q,GtoQ,lri,rri,ripregensfac,overgp,i,kgens;

 # remember the kernel of ri!
 kerfac := kernel(ri);;
 
 # construct maps from ri -> new groups
 phi := StructuralCopy(Homom(ri));
 Q := List(maps,x->Image(x));
 GtoQ := List([1..Length(Q)],i->GroupHomomorphismByFunction(Grp(ri),Q[i],g->ImageElm(maps[i],ImageElm(phi,g))));


 lri := []; rri := [];
 lri[1] := rec();
 Objectify(RecognitionInfoType,lri[1]);;
  
 SetGrp(lri[1],Grp(ri));

 ripregensfac := ShallowCopy(pregensfac(ri));
 overgp := ShallowCopy(overgroup(ri));
 Setovergroup(lri[1],overgp);

 for i in [1..Length(Q)] do
   rri[i] := rec();
   Objectify(RecognitionInfoType,rri[i]);;
   SetGrp(rri[i],Q[i]);
   SetHomom(lri[i],GtoQ[i]);
   SetNiceGens(rri[i],AsList(Pcgs(Q[i])));
   Setslpforelement(rri[i],SolvePcWord);
   Setpregensfac(lri[i],List(NiceGens(rri[i]),x-> ResultOfStraightLineProgram(slpforelement(rifac)(rifac,PreImagesRepresentative(maps[i],x)),ripregensfac)));
   Setcalcnicegens(lri[i],CalcNiceGensHomNode);
   lri[i]!.nrgensH := Length(GeneratorsOfGroup(Grp(lri[i])));
   Setovergroup(lri[i],overgp);
   Setcalcnicegens(lri[i],CalcNiceGensGeneric);
   Setslpforelement(lri[i],SLPforElementGeneric);
   SetFilterObj(rri[i],IsLeaf);
   SetFilterObj(rri[i],IsReady);
   SetFilterObj(lri[i],IsReady);

   lri[i]!.genswithmem := GeneratorsWithMemory(
            Concatenation(GeneratorsOfGroup(Grp(lri[i])),pregensfac(lri[i])));
   lri[i]!.groupmem := Group(lri[i]!.genswithmem{[1..lri[i]!.nrgensH]});
   # FIXME: This is broken due to the new random element infrastructure!


# Setup the kernel

   if kerfac <> fail then
     kgens := Concatenation(GeneratorsOfGroup(Grp(kerfac)),List(GeneratorsOfGroup(Kernel(maps[i])),x->ResultOfStraightLineProgram(slpforelement(rifac)(rifac,x),ripregensfac)));   
   else
     kgens := List(GeneratorsOfGroup(Kernel(maps[i])),x->ResultOfStraightLineProgram(slpforelement(rifac)(rifac,x),ripregensfac));   
   fi;
   if Length(kgens)=0 then
     kgens := [One(overgp)];
   fi;
   lri[i+1] := rec();
   Objectify(RecognitionInfoType,lri[i+1]);;
   SetGrp(lri[i+1],GroupWithGenerators(kgens));
   Setkernel(lri[i],lri[i+1]);
   Setfactor(lri[i],rri[i]);	
   Setparent(lri[i+1],lri[i]);
   Setparent(rri[i],lri[i]);   
 od;  

   
 # tell lri[1] to join onto parent(ri)
 if Hasparent(ri) then
   Setparent(lri[1],StructuralCopy(parent(ri)));
 fi;

 # tell last lri to be kerfac
   Setkernel(lri[Size(Q)],StructuralCopy(kerfac));
   Setparent(kernel(lri[Size(Q)]),lri[Size(Q)]);
 
 # Set up the nice generators

 i := Size(Q);
 while i>0 do
   if kernel(lri[i]) <> fail then
     SetNiceGens(lri[i],Concatenation(pregensfac(lri[i]),NiceGens(kernel(lri[i]))));
   else
     SetNiceGens(lri[i],pregensfac(lri[i]));
   fi;
   i := i - 1;
 od;

 return lri[1];
end;


RefineSolubleLayers := function(ri)
 local rifac,phi,I,L,maps,riker;

 if ri=fail then return ri; fi;

 rifac := factor(ri);;
 phi := Homom(ri);
 I := Grp(rifac);

 if not IsPcGroup(I) or IsElementaryAbelian(I) then 
   riker := kernel(ri);
   Setkernel(ri,RefineSolubleLayers(riker));
   if kernel(ri)<>fail then
     SetNiceGens(ri,Concatenation(pregensfac(ri),NiceGens(kernel(ri))));
   else
     SetNiceGens(ri,pregensfac(ri));
   fi;
   return ri;
 fi;

  L := InvariantElementaryAbelianSeries(I,GeneratorsOfGroup(AutomorphismGroup(I)) : fine := true);
  maps := List([1..Length(L)-1],i->NaturalHomomorphismByNormalSubgroupNC(L[i],L[i+1]));
  ri := InsertSubTree(ri, rifac, maps);;
  riker := kernel(ri);
  Setkernel(ri,RefineSolubleLayers(riker));
  Setparent(kernel(ri),ri);
  if kernel(ri)<>fail then
    SetNiceGens(ri,Concatenation(pregensfac(ri),NiceGens(kernel(ri))));
  else
    SetNiceGens(ri,pregensfac(ri));
  fi;

  return ri;
end;


ConstructActionMatrices := function(ri)
# Constructs the action matrices of the overgroup on the elementary abelian layer
 local AcGens,x,g;

 AcGens := [];
 for g in GeneratorsOfGroup(overgroup(ri)) do
   Add(AcGens,List(pregensfac(ri),x->ExponentsOfPcElement(Pcgs(factor(ri)!.group),ImageElm(Homom(ri),x^g))));
 od;

 return AcGens;
end; 
 
VectortoPc := function(v,Pc)
 return PcElementByExponents(Pcgs(Pc),List(v,x->IntFFE(x)));
end;

RefineElementaryAbelianLayers := function(ri)
 local rifac,phi,I,L,maps,riker,AcGens,CS,p,M,v;

 if ri=fail then return ri; fi;

 rifac := factor(ri);;
 phi := Homom(ri);
 I := Grp(rifac);

 if not IsPcGroup(I) or IsCyclic(I) then 
   riker := kernel(ri);
   Setkernel(ri,RefineElementaryAbelianLayers(riker));
   if kernel(ri)<>fail then
     SetNiceGens(ri,Concatenation(pregensfac(ri),NiceGens(kernel(ri))));
   else
     SetNiceGens(ri,pregensfac(ri));
   fi;
   return ri;
 fi;

 AcGens := ConstructActionMatrices(ri);  
 p := I!.Pcgs!.RelativeOrders[1];
 M := GModuleByMats(Z(p)^0*AcGens,GF(p));

 #if the module is irreducible then the ChiefSeries can't be refined.
 if MTX.IsIrreducible(M) then 
   riker := kernel(ri);
   Setkernel(ri,RefineElementaryAbelianLayers(riker));
   if kernel(ri)<>fail then
     SetNiceGens(ri,Concatenation(pregensfac(ri),NiceGens(kernel(ri))));
   else
     SetNiceGens(ri,pregensfac(ri));
   fi;
   
   return ri;
 fi;

 CS := MTX.BasesCompositionSeries(M);


# get the list of normal subgroups
  
  L := List([Length(CS),Length(CS)-1..1],i->
SubgroupNC(Grp(factor(ri)),List(CS[i],v->VectortoPc(v,Grp(factor(ri))))));
  
  maps := List([1..Length(L)-1],i->NaturalHomomorphismByNormalSubgroupNC(L[i],L[i+1]));
  ri := InsertSubTree(ri, rifac, maps);;
  riker := kernel(ri);
  Setkernel(ri,RefineElementaryAbelianLayers(riker));
  Setparent(kernel(ri),ri);
  if kernel(ri)<>fail then
    SetNiceGens(ri,Concatenation(pregensfac(ri),NiceGens(kernel(ri))));
  else
    SetNiceGens(ri,pregensfac(ri));
  fi;

  return ri;
end;

RemoveTrivialLayers := function(ri)
# Removes the trivial layers
 local rifac,riker,I,parri,newriker;
 
 if ri=fail then return ri; fi;

 rifac := factor(ri);;
 riker := kernel(ri);;
 I := Grp(rifac);
 if IsPcGroup(I) and IsTrivial(I) then
# I is trivial!!
   if Hasparent(ri) then
     parri := StructuralCopy(parent(ri));
   fi;
   ri := riker;;
   if IsBound(parri) then
     Setparent(ri,parri);
   else
     Unbind(ri!.parent);
     ResetFilterObj(ri, Hasparent);
   fi; 
   newriker := kernel(ri);
   Setkernel(ri,RemoveTrivialLayers(newriker));
   if kernel(ri)<>fail then
     SetNiceGens(ri,Concatenation(pregensfac(ri),NiceGens(kernel(ri))));
   else
     SetNiceGens(ri,pregensfac(ri));
   fi;

   return RemoveTrivialLayers(ri);
 fi;

 Setkernel(ri,RemoveTrivialLayers(riker));   
 if kernel(ri)<>fail then
   SetNiceGens(ri,Concatenation(pregensfac(ri),NiceGens(kernel(ri))));
 else
   SetNiceGens(ri,pregensfac(ri));
 fi;
 return ri;
end;

with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body LCA is

   procedure Free is
     new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


   procedure Initialiser(Sda: out T_LCA) is
   begin
      Sda := null;
   end Initialiser;


   procedure Detruire (Sda : in out T_LCA) is
   begin
      Free(Sda);
      Sda := null;
   end Detruire;


   procedure Afficher_Debug (Sda : in T_LCA) is
      Curseur : T_LCA;
   begin
      Curseur := Sda;
      while Curseur/= null and then Curseur.all.Suivant /= null loop
         Put("-->[ ");
         Afficher_Cle(Curseur.all.Cle);
         Put(" : ");
         Afficher_Valeur(Curseur.all.Valeur);
         Put("]")
           Curseur := Curseur.all.Suivant;
      end loop;
      Curseur := null;
      Put("--E");
   end Afficher_Debug;


   function Est_Vide (Sda : T_LCA) return Boolean is
   begin
      return Sda = null;
   end;


   function Taille (Sda : in T_LCA) return Integer is
      taille : Integer;
      Curseur : T_LCA;
   begin
      if Est_Vide(Sda) then
         return 0;
      else
         taille := 1;
         Curseur := Sda;
         while Curseur.all.Suivant /= null loop
            taille:= taille +1;
            Curseur := Curseur.all.Suivant;
         end loop;
      end if
      return taille;
   end Taille;


   procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Valeur : in T_Valeur) is
      Curseur : T_LCA;
      CleTrouvé: Boolean;
   begin
      if Est_Vide(Sda) then
         Curseur := new T_Cellule'(Cle,Valeur,null);
      else
         CleTrouvé := False;
         while !CleTrouvé and Curseur.all.Suivant /= null loop
            if Curseur.all.Cle = Cle then
               CleTrouvé := True;
            end if;
            Curseur := Curseur.all.Suivant;
         end loop;
      end if;


      Curseur := new T_Cellule'(Cle,Valeur,Sda);
      Sda := Curseur;
      Curseur := null;

   end Enregistrer;


   function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
      Curseur : T_LCA;
   begin
      if Est_Vide(Sda) then
         return False;
      else
         Curseur := Sda;
         while Curseur.all.Suivant /= null loop
            if Curseur.all.Cle = Cle then
               return True;
            else
               Curseur := Curseur.all.Suivant;
            end if;
         end loop;
         return False;

      end;


      function La_Valeur (Sda : in T_LCA ; Cle : in T_Cle) return T_Valeur is

         Curseur : T_LCA;
      begin
         if Est_Vide(Sda) then
            raise
      end La_Valeur;


      procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
      begin
         null;	-- TODO : Ã  changer
      end Supprimer;


      procedure Pour_Chaque (Sda : in T_LCA) is
      begin
         null;	-- TODO : Ã  changer
      end Pour_Chaque;


   end LCA;

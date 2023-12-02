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
      New_Line;
      while Curseur/= null loop
         Put("-->[ ");
         Afficher_Cle(Curseur.all.Cle);
         Put(" : ");
         Afficher_Donnee(Curseur.all.Valeur);
         Put("]");
         Curseur := Curseur.all.Suivant;
      end loop;
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
      if Sda = null then
         return 0;
      else
         taille := 1;
         Curseur := Sda;
         while Curseur.all.Suivant /= null loop
            taille:= taille +1;
            Curseur := Curseur.all.Suivant;
         end loop;
         return taille;
      end if;

   end Taille;


   procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Valeur : in T_Valeur) is
   begin
      if Sda = null then
         Sda := new T_Cellule'(Cle,Valeur,null);
      else if Sda.Cle = Cle then
            Sda.Valeur := Valeur;
         else
            Enregistrer(Sda.Suivant,Cle,Valeur);
         end if;
      end if;
   end Enregistrer;


   function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
      Curseur : T_LCA;
   begin

         Curseur := Sda;
         while Curseur /= null loop
            if Curseur.all.Cle = Cle then
               return True;
            else
               Curseur := Curseur.all.Suivant;
            end if;
         end loop;
         return False;

   end Cle_Presente;


   function La_Valeur (Sda : in T_LCA ; Cle : in T_Cle) return T_Valeur is
      Curseur : T_LCA;
   begin

      if Sda = null then
         raise Cle_Absente_Exception;
      else
         Curseur := Sda;
         while Curseur.Suivant /= null and Curseur.Cle /= Cle loop
            Curseur := Curseur.Suivant;
         end loop;
         if Curseur.Cle = Cle then
            return Curseur.Valeur;
         else
            raise Cle_Absente_Exception;
         end if;
      end if;
   end La_Valeur;



   procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
      Curseur : T_LCA;
      CurseurApres : T_LCA;
   begin

      if Sda = null then
         raise Cle_Absente_Exception;
      else
         Curseur := Sda;
         CurseurApres := Sda;
         If Sda.Cle = Cle then
            Sda := Sda.Suivant;
         else if CurseurApres.Suivant /= null then
               CurseurApres := CurseurApres.Suivant;
            end if;
         end if;
         while CurseurApres.Suivant /= null and CurseurApres.Cle /= Cle loop
            Curseur := Curseur.Suivant;
            CurseurApres := CurseurApres.Suivant;
         end loop;
         if CurseurApres.Cle = Cle and CurseurApres.Suivant = null then
            Curseur.Suivant := null;
         else if CurseurApres.Cle = Cle and CurseurApres.Suivant /= null then
               Curseur.Suivant := CurseurApres.Suivant;
            else
               raise Cle_Absente_Exception ;

            end if;
         end if;
      end if;
   end Supprimer;


   procedure Pour_Chaque (Sda : in T_LCA) is
      Curseur: T_LCA;
   begin
      Curseur := Sda;
      while Curseur /=null loop
         begin
            Traiter(Curseur.Cle, Curseur.Valeur);
         exception
            when others =>
               Put_Line("Traitement échoué pour cet élement");
         end;
         Curseur := Curseur.Suivant;
      end loop;

   end Pour_Chaque;

end LCA;



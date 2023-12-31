with Ada.Text_IO;            use Ada.Text_IO;

package body TH is

   procedure Initialiser(TH: out T_TH) is
   begin
      for i in 1..Capacite loop
         Initialiser(TH(i));
      end loop;
   end Initialiser;


   procedure Detruire (TH : in out T_TH) is
   begin
      for i in 1..Capacite loop
         Detruire(TH(i));
      end loop;

   end Detruire;


   procedure Afficher_Debug (TH : in T_TH) is
      procedure Afficher_LCA is new TH_LCA.Afficher_Debug(Afficher_Cle, Afficher_Donnee);
   begin
      Put("[ ");
      for i in 1..Capacite loop

         Afficher_LCA(TH(i));
         Put(" ,");
         if i = Capacite then
            Afficher_LCA(TH(i));
         end if;
      end loop;
      New_Line;
      Put_Line(" ]");
   end Afficher_Debug;


   function Est_Vide (TH : T_TH) return Boolean is
   begin
      for i in 1..Capacite loop
         if not Est_Vide(TH(i)) then
            return False;
         end if;
      end loop;
      return True;
   end;


   function Taille (TH : in T_TH) return Integer is
      taille : Integer;
   begin
      taille := 0;
      for i in 1..Capacite loop
         taille := taille + TH_LCA.Taille(TH(i));
      end loop;
      return taille;
   end Taille;


   procedure Enregistrer (TH : in out T_TH ; Cle : in T_Cle ; Valeur : in T_Valeur) is
   begin
      Enregistrer(TH(hacher(Cle) mod Capacite + 1), Cle, Valeur);
   end Enregistrer;


   function Cle_Presente (TH : in T_TH ; Cle : in T_Cle) return Boolean is
   begin

      return Cle_Presente(TH(hacher(Cle) mod Capacite + 1), Cle);

   end Cle_Presente;


   function La_Valeur (TH : in T_TH ; Cle : in T_Cle) return T_Valeur is
   begin

      return La_Valeur(TH(hacher(Cle) mod Capacite + 1), Cle);

   end La_Valeur;



   procedure Supprimer (TH : in out T_TH ; Cle : in T_Cle) is
   begin
      Supprimer(TH(hacher(Cle) mod Capacite + 1),Cle);
   end Supprimer;


   procedure Pour_Chaque (TH : in T_TH) is
      procedure Pour_Chaque is new TH_LCA.Pour_Chaque(Traiter);
   begin
      for i in 1..Capacite loop
         Pour_Chaque(TH(i));
      end loop;
   end Pour_Chaque;
end TH;

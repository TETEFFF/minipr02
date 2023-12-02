with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;  use  Ada.Text_IO.Unbounded_IO;
with TH;


procedure TH_sujet is

   procedure Afficher_Entier( Ent: in Integer)is
   begin
      Put(Ent,1);
   end Afficher_Entier;

   function Longueur_Cle( Cle: in Unbounded_String) return Integer is
   begin
      return To_String(Cle)'Length;
   end Longueur_Cle;

   package th_str_int is
     new TH (T_Cle => Unbounded_String,T_Valeur => Integer, Capacite => 11, hacher => Longueur_Cle);
   use th_str_int;

   procedure Afficher_Liste is new Afficher_Debug(Put, Afficher_Entier);

   TH : T_TH;
begin
   Initialiser(TH);
   Enregistrer(TH,To_Unbounded_String("un"),1);
   Enregistrer(TH,To_Unbounded_String("deux"),2);
   Enregistrer(TH,To_Unbounded_String("trois"),3);
   Enregistrer(TH,To_Unbounded_String("quatre"),4);
   Enregistrer(TH,To_Unbounded_String("cinq"),5);
   Enregistrer(TH,To_Unbounded_String("quatre-vingt-dix-neuf"),99);
   Enregistrer(TH,To_Unbounded_String("vingt-et-un"),21);
   Afficher_Liste(TH);
end TH_sujet;

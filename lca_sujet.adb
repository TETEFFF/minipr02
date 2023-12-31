with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;  use  Ada.Text_IO.Unbounded_IO;
with lca;


procedure lca_sujet is

   procedure Afficher_Entier( Ent: in Integer)is
   begin
      Put(Ent,1);
   end Afficher_Entier;

   package lca_str_int is
     new lca (T_Cle => Unbounded_String,T_Valeur => Integer);
   use lca_str_int;

   procedure Afficher_Liste is new Afficher_Debug(Put, Afficher_Entier);

   LCA : T_LCA;
begin
   Initialiser(LCA);
   if Est_Vide(LCA) then
      put("liste vide");
   end if;
   Enregistrer(LCA, To_Unbounded_String("un"), 1);
   Enregistrer(LCA, To_Unbounded_String("deux"), 2);
   Enregistrer(LCA, To_Unbounded_String("troix"),3);
   Afficher_Liste(LCA);
   Supprimer(LCA,To_Unbounded_String("un"));
   Afficher_Liste(LCA);
   Enregistrer(LCA,To_Unbounded_String("deux"),4);
   Afficher_Liste(LCA);
   Detruire(LCA);


end lca_sujet;

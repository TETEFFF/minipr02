
-- D�finition de structures de donn�es associatives sous forme d'une liste
-- cha�n�e associative (LCA).
generic
   type T_Cle is private;
   type T_Valeur is private;

package LCA is

   type T_LCA is limited private;

   -- Initialiser une Sda.  La Sda est vide.
   procedure Initialiser(Sda: out T_LCA) with
     Post => Est_Vide (Sda);


   -- D�truire une Sda.  Elle ne devra plus �tre utilis�e.
   procedure Detruire (Sda : in out T_LCA);


   -- Est-ce qu'une Sda est vide ?
   function Est_Vide (Sda : T_LCA) return Boolean;


   -- Obtenir le nombre d'�l�ments d'une Sda. 
   function Taille (Sda : in T_LCA) return Integer with
     Post => Taille'Result >= 0
     and (Taille'Result = 0) = Est_Vide (Sda);


   -- Enregistrer une valeur associ�e à une Cl� dans une Sda.
   -- Si la cl� est d�ja� pr�sente dans la Sda, sa valeur est chang�e.
   procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Valeur : in T_Valeur) with
     Post => Cle_Presente (Sda, Cle) and (La_Valeur (Sda, Cle) = Valeur)   -- valeur insérée
     and (not (Cle_Presente (Sda, Cle)'Old) or Taille (Sda) = Taille (Sda)'Old)
     and (Cle_Presente (Sda, Cle)'Old or Taille (Sda) = Taille (Sda)'Old + 1);


   -- Supprimer la valeur associ�e à une Cl� dans une Sda.
   -- Exception : Cle_Absente_Exception si Clé n'est pas utilis�e dans la Sda
   procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) with
     Post =>  Taille (Sda) = Taille (Sda)'Old - 1 -- un �l�ment de moins
     and not Cle_Presente (Sda, Cle);         -- la cl� a �t� supprim�e


   -- Savoir si une Cl� est pr�sente dans une Sda.
   function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean;


   -- Obtenir la valeur associ�e à une Cle dans la Sda.
   -- Exception : Cle_Absente_Exception si Cl� n'est pas utilis�e dans l'Sda
   function La_Valeur (Sda : in T_LCA ; Cle : in T_Cle) return T_Valeur;


   -- Appliquer un traitement (Traiter) pour chaque couple d'une Sda.
   generic
      with procedure Traiter (Cle : in T_Cle; Valeur: in T_Valeur);
   procedure Pour_Chaque (Sda : in T_LCA);


   -- Afficher la Sda en r�v�lant sa structure interne.
   -- Voici un exemple d'affichage.
   -- -->["un" : 1]-->["deux" : 2]-->["trois" : 3]-->["quatre" : 4]--E
   generic
      with procedure Afficher_Cle (Cle : in T_Cle);
      with procedure Afficher_Donnee (Valeur : in T_Valeur);
   procedure Afficher_Debug (Sda : in T_LCA);


private
   
   type T_Cellule;
   type T_LCA is access T_Cellule;
   type T_Cellule is record
      Cle:T_Cle;
      Valeur: T_Valeur;
      Suivant: T_LCA;
   end record;

end LCA;

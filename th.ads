with LCA;

generic
   type T_Cle is private;
   type T_Valeur is private;
   Capacite: Integer;
   with function hacher( Cle : in T_Cle) return Integer;

package TH is
   type T_TH is limited private;

   -- Initialiser une TH.  La TH est vide.
   procedure Initialiser(TH: out T_TH) with
     Post => Est_Vide (TH);


   -- Détruire une TH.  Elle ne devra plus être utilisée.
   procedure Detruire (TH : in out T_TH);


   -- Est-ce qu'une TH est vide ?
   function Est_Vide (TH : T_TH) return Boolean;


   -- Obtenir le nombre d'éléments d'une TH.
   function Taille (TH : in T_TH) return Integer with
     Post => Taille'Result >= 0
     and (Taille'Result = 0) = Est_Vide (TH);


   -- Enregistrer une valeur associée Ã  une Clé dans une TH.
   -- Si la clé est déja  présente dans la TH, sa valeur est changée.
   procedure Enregistrer (TH : in out T_TH ; Cle : in T_Cle ; Valeur : in T_Valeur) with
     Post => Cle_Presente (TH, Cle) and (La_Valeur (TH, Cle) = Valeur)   -- valeur insérée
     and (not (Cle_Presente (TH, Cle)'Old) or Taille (TH) = Taille (TH)'Old)
     and (Cle_Presente (TH, Cle)'Old or Taille (TH) = Taille (TH)'Old + 1);


   -- Supprimer la valeur associée Ã  une Clé dans une TH.
   -- Exception : Cle_Absente_Exception si ClÃ© n'est pas utilisée dans la TH
   procedure Supprimer (TH : in out T_TH ; Cle : in T_Cle) with
     Post =>  Taille (TH) = Taille (TH)'Old - 1 -- un élément de moins
     and not Cle_Presente (TH, Cle);         -- la clé a été supprimée


   -- Savoir si une Clé est présente dans une TH.
   function Cle_Presente (TH : in T_TH ; Cle : in T_Cle) return Boolean;


   -- Obtenir la valeur associée Ã  une Cle dans la TH.
   -- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans l'TH
   function La_Valeur (TH : in T_TH ; Cle : in T_Cle) return T_Valeur;


   -- Appliquer un traitement (Traiter) pour chaque couple d'une TH.
   generic
      with procedure Traiter (Cle : in T_Cle; Valeur: in T_Valeur);
   procedure Pour_Chaque (TH : in T_TH);


   -- Afficher la TH en révélant sa structure interne.
   -- Voici un exemple d'affichage.
   --  -->["un" : 1]-->["deux" : 2]-->["trois" : 3]-->["quatre" : 4]--
   generic
      with procedure Afficher_Cle (Cle : in T_Cle);
      with procedure Afficher_Donnee (Valeur : in T_Valeur);
   procedure Afficher_Debug (TH : in T_TH);


private
   package TH_LCA is new LCA(T_Cle => T_Cle, T_Valeur => T_Valeur);
   use TH_LCA;

   type T_TH is array (1..Capacite) of T_LCA;

end TH;

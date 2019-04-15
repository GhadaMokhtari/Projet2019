<%-- 
    Document   : affiche
    Created on : 2 avr. 2019, 14:06:27
    Author     : infoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/affiche.css">
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <!-- On charge le moteur de template mustache https://mustache.github.io/ -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        <title>JSP Page</title>
    </head>
    <STYLE>A {text-decoration: none; color: black;} </STYLE>
    <body>
        <nav class="barAffiche">
            <ol>
                <li class="a2"><a href=""></a> Accueil </li>
                <li class="a2"><a href=""> Votre compte </a> </li>
                <li class="a2"><a href=""></a> Déconnexion </li>
            </ol>
        </nav>
        <script>
            $(document).ready(// Exécuté à la fin du chargement de la page
                    function () {
                        // On montre la liste des codes
                        showCommandes();
                    }
            );

            function showCommandes() {
                console.log("entrer");
                // On fait un appel AJAX pour chercher les codes
                $.ajax({
                    url: "PurchaseOder",
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les résultats
                            function (result) {
                                
                                
                                console.log(result);
                                // Le code source du template est dans la page
                                var template = $('#commandesTemplate').html();
                                // On combine le template avec le résultat de la requête
                                var processedTemplate = Mustache.to_html(template, result);
                                // On affiche la liste des options dans le select
                                $('#commandes').html(processedTemplate);
                            }
                });
            }

            // Supprimer un code
            function deleteCommande(ordernum) {
                $.ajax({
                    url: "deleteCommande",
                    data: {"ordernum": ordernum},
                    dataType: "json",
                    success:
                            function (result) {
                                showCommandes();
                                console.log(result);
                            },
                    error: showError
                });
                return false;
            }

            // Fonction qui traite les erreurs de la requête
            function showError(xhr, status, message) {
                alert(JSON.parse(xhr.responseText).message);
            }

        </script>
        <h1> Mes commandes </h1>
        <table id="commandes">
            
        </table>
        <a  href="ajoutecommande.jsp?action=ADDCOMMANDE" >
        <input class="a" type="button" value="Ajouter une commande">
       </a>

        <!-- Le template qui sert à formatter la liste des codes -->
        <script id="commandesTemplate" type="text/template">
            <TABLE>
            <tr><th>Numéro de commande</th><th>ID Client</th><th>ID Produit</th><th>Quantité</th><th>Prix de livraison</th><th>Date de Vente</th><th>Date de Livraison</th><th>Companie de livraison</th></tr>
            {{! Pour chaque enregistrement }}
            {{#records}}
                {{! Une ligne dans la table }}
                <TR><TD>{{ordernum}}</TD><TD>{{idcustomer}}</TD><TD>{{idproduct}}</TD><TD>{{quantity}}</TD><TD>{{shippingcost}}</TD><TD>{{salesDate}}</TD><TD>{{shippingDate}}</TD><TD>{{company}}</TD><TD><button class="b1"><a href="">Modifier</a></button></TD><TD><button class="b1" onclick="deleteCommande('{{ordernum}}')">Supprimer</button></TD></TR>
            {{/records}}
            </TABLE>
            
            
        </script>

            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</body>

</html>




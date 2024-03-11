<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Foodie.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome</title>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Hello Program in Angular JS</h1>
        <%--<div ng-app="">
           <div ng-init="greet='Hello'; amount=200; myArr =[200,300]; person={firstname:'Anshika', lastName:'Prajapati'}">
               {{amount }}<br />
               {{myArr[1]}}<br />
               {{person.firstname}}
           </div>
            <div>
                <input type="text" ng-model="name" /><br />
                <p>Hello {{name}}</p>
            </div>
        </div>--%>

       <%-- <div data-ng-app="" data-ng-init="quantity=3; price=10">
            <h2>Cost calculator</h2>
            Quantity: <input type="number" ng-model="quantity" />
            Price (Per qty): <input type="number" ng-model="price" />
            <p><b>Total in ruppee :</b>{{quantity*price}}</p>
        </div>--%>

        <%--<div ng-app="" ng-init="names=[
            {name: 'Pooja', age: 20},
            {name: 'Ashish', age: 23}]">
            <p>Looping with objects</p>
            <ul>
                <li ng-repeat="x in names">
                    {{x.name +','+ x.age}}
                </li>
            </ul>
        </div>--%>

        <%--<div ng-app="" ng-init="myColor='Yellow'">
            <input style="background-color:{{myColor}}" ng-model="myColor" />
        </div>--%>

        <%--<div ng-app="" ng-init="quantity=2; price=20">
            <p>Total Price : <span ng-bind="quantity*price"></span></p>
        </div>--%>

        <%--<div ng-app="" ng-init="firstname:'Anshika'; lastname:'Prajapati'">
            <p>Full Name : <span ng-bind="firstname +' '+ lastname"></span></p>
        </div>--%>

        <%--<div  ng-app="" ng-init="person={firstname:'Anshika', lastname:'Prajapati'}">
            <p>Name is {{ person.firstname +' '+ person.lastname}}</p>
        </div>--%>

        <%--<div ng-app="" ng-init="myArray=[1,2,3,4,5]">
            <p>Array is {{myArray[2]}}</p>
        </div>--%>
    </form>
</body>
</html>

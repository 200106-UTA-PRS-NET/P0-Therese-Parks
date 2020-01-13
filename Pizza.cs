using System;
using System.Collections.Generic;
using System.Text;

namespace PizzaBox.Domain.Abstracts
{
    // A pizza does not rely on anyone--> makes good abstract class
    // There should be different kinds of Pizza's and all should have
    // Certain requirements, So Abstract class makes sense here.

    abstract class Pizza
    {

        // using auto properties where all we need to do is get and set and no no other logic
        public int id { get; set; }
        public string crust { get; set; }//should have a crust
        public string size { get; set; } // should have a size(state)
        public double cost { get; set; } // should have a cost(state)
        public string cheese { get; set; }// should have default topping 1(state)
        public string sauce { get; set; }// should have default topping 2(state)

        private readonly int _limit = 5; // unchangeble limit of 5 topings

        public int Limit // Property for another class to access limit, but can't change it
        {
            get
            {
                return _limit;
            }
        }


    }
}

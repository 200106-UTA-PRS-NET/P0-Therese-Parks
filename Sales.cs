using System;
using System.Collections.Generic;
using System.Text;

namespace PizzaBox.Domain.Models
{
    // A sale is a completed order
    // I'm sealing it because the sale is what goes on the receipt
    // A receipt could be accessed, but not changed
    sealed class Sales
    {
    }
}

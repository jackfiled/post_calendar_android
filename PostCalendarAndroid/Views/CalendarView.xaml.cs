using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace PostCalendarAndroid.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class CalendarView : ContentPage
    {
        public CalendarView()
        {
            InitializeComponent();
        }
    }
}
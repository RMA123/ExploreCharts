//
//  ViewController.swift
//  exploreCharts
//
//  Created by LTI Macbook on 9/7/16.
//  Copyright © 2016 Phillips66. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    //    @IBOutlet var chartView: BarChartView!
//    @IBOutlet var chartView: PieChartView!
    
    var months:[String]!
    var unitsSold:[Double]!
    var barChartView:BarChartView!
    var pieChartView:PieChartView!
    var lineChartView:LineChartView!
    var scrollView: UIScrollView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Set up data
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        scrollView = UIScrollView()
        barChartView = BarChartView()
        pieChartView = PieChartView()
        lineChartView = LineChartView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confiureChartView(barChartView, type: 0)
        setupBarChart()
        setupPieChart()
        setupLineChart()
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(barChartView)
        self.scrollView.addSubview(pieChartView)
        self.scrollView.addSubview(lineChartView)
        
        self.navigationItem.title = "IOS Charts"
        
        //Add savebutton
//        let rightButton = UIBarButtonItem.init(title: "SAVE", style: UIBarButtonItemStyle.Plain, target: self, action: Selector(saveChart()))
//        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
        barChartView.frame = CGRectMake(0, 0, self.view.layer.bounds.size.width, self.view.layer.bounds.size.height / 3)
        pieChartView.frame = CGRectMake(0, barChartView.layer.bounds.height + 20, self.view.layer.bounds.size.width, self.view.layer.bounds.size.height / 3)
        lineChartView.frame = CGRectMake(0, barChartView.layer.bounds.height * 2 + 40, self.view.layer.bounds.size.width, self.view.layer.bounds.size.height / 3)
        
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, barChartView.layer.bounds.height * 4)
    }
    
    func confiureChartView(p_chartView:UIView, type:Int) {

        
        if type == 0
        {
            let chartView = p_chartView as! BarChartView
            
            //Change label position - Only for bar charts
            chartView.xAxis.labelPosition = .Bottom
            
            //Description text
            chartView.descriptionText = ""
            
            //Change background color
            chartView.backgroundColor = UIColor.lightGrayColor()
            
            //Add animation
            chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            
            //Add limit line - Only for bar charts
            let limitLine = ChartLimitLine(limit: 10.0, label: "Target")
            chartView.rightAxis.addLimitLine(limitLine)
            
            //Respond to touches
            chartView.delegate = self
        }
        else if type == 1
        {
            let chartView = p_chartView as! PieChartView
            
            //Description text
            chartView.descriptionText = ""
            
            //Change background color
            chartView.backgroundColor = UIColor.lightGrayColor()
            
            //Add animation
            chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            
            //Respond to touches
            chartView.delegate = self
        }
        
        else if type == 2
        {
            let chartView = p_chartView as! LineChartView
            
            //Description text
            chartView.descriptionText = ""
            
            //Change background color
            chartView.backgroundColor = UIColor.lightGrayColor()
            
            //Add animation
            chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            
            //Respond to touches
            chartView.delegate = self
        }
        
    }
    
    func setupBarChart() {
        //Build y Axis entries
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<unitsSold!.count {
            let dataEntry = BarChartDataEntry(value: unitsSold![i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        // ++ Bar chart ++++++++++
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Unit Sales")
        //Y axis color
        //        chartDataSet.colors = [UIColor.redColor()]
        chartDataSet.colors = ChartColorTemplates.joyful()
        
        //Setup X and y Axis
        let chartData = BarChartData(xVals: months, dataSets: [chartDataSet])
        
        //Bind the data to chartview
        barChartView.data = chartData
        //++++++++++++++++++++++++
        
    }
    
    func setupPieChart() {
        
        // ++ Pie Chart ++++++++++
        
        //Build y Axis entries
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<unitsSold!.count {
            let dataEntry = ChartDataEntry(value: unitsSold![i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = PieChartDataSet(yVals: dataEntries, label: "Unit Sales")
        //Y axis color
        //        chartDataSet.colors = [UIColor.redColor()]
        chartDataSet.colors = ChartColorTemplates.joyful()
        
        //Setup X and y Axis
        let chartData = PieChartData(xVals: months, dataSets: [chartDataSet])
        //++++++++++++++++++++++++
        
        //Bind the data to chartview
        pieChartView.data = chartData
        
    }
    
    func setupLineChart() {
        // ++ Line Chart ++++++++++
        
        //Build y Axis entries
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<unitsSold!.count {
            let dataEntry = ChartDataEntry(value: unitsSold![i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Unit Sales")
        //Y axis color
        //        chartDataSet.colors = [UIColor.redColor()]
        chartDataSet.colors = ChartColorTemplates.joyful()
        
        //Setup X and y Axis
        let chartData = LineChartData(xVals: months, dataSets: [chartDataSet])
        //++++++++++++++++++++++++
        
        //Bind the data to chartview
        lineChartView.data = chartData
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func saveChart() {
////        chartView.saveToCameraRoll()
//    }
}

extension ViewController:ChartViewDelegate
{
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        let alertController:UIAlertController = UIAlertController.init(title: "Selection", message: "\(entry.value) \(months![entry.xIndex])", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Cancel, handler: {_ in
        }))
        self.presentViewController(alertController, animated: false, completion: nil)
        
    }
    
}


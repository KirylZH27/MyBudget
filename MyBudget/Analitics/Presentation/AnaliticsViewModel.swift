//
//  AnaliticsViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 26.07.23.
//

import Foundation
import AAInfographics
import Combine

final class AnaliticsViewModel {
    
    private let transactionGetter: TransactionGetter
    
    private (set) var totalChartModelCalculated = PassthroughSubject<AAChartModel,Never>()
    
    init(transactionGetter: TransactionGetter) {
        self.transactionGetter = transactionGetter
    }
    
    func getTotalChartModel(){
        getTransactionsByWeek { transactions in
            let incomeDictionary = self.getTransactionDictionaryValue(transactions: transactions, type: .income, days: 7)
            let expenditureDictionary = self.getTransactionDictionaryValue(transactions: transactions, type: .expenditure, days: 7)
            let categories = incomeDictionary.keys.sorted { $0 < $1 }
            
            var incomeValues: [Double] = []
            var expenditureValues: [Double] = []
            
            for key in categories {
                guard let incomeValue = incomeDictionary[key] else { return }
                guard let expenditureValue = expenditureDictionary[key] else { return }
                incomeValues.append(incomeValue)
                expenditureValues.append(expenditureValue)
            }
            
            let aaChartModel = AAChartModel()
                .chartType(.area)
                .animationType(.bounce)
                .title("История операций")
                .tooltipValueSuffix("Br")
                .categories(categories)
                .series([
                    AASeriesElement()
                        .name("Доходы")
                        .data(incomeValues),
                    
                    AASeriesElement()
                        .name("Расходы")
                        .color("#901F4C")
                        .data(expenditureValues)
                ])
            self.totalChartModelCalculated.send(aaChartModel)
        }
    }
    
    private func getTransactionsByWeek(completion: @escaping([TransactionDescription]) -> Void){
        transactionGetter.getAllTransactions { allTransactions in
            let calendar = Calendar.current
            guard let weakAgoDate = calendar.date(byAdding: .day, value: -7, to: Date()) else { return }
            let dateForamtter = DateFormatter()
            dateForamtter.dateFormat = "dd.MM.yyyy"
            let weakAgoDateString = dateForamtter.string(from: weakAgoDate)
            let filteredTransaction = allTransactions.filter { transaction in
                let transactionDateString = dateForamtter.string(from: transaction.date)
                return transactionDateString >= weakAgoDateString
            }
            completion(filteredTransaction)
        }
    }
    
    private func getTransactionDictionaryValue(transactions: [TransactionDescription], type: TransactionType, days: Int) -> [String: Double]{
        
        let typeTransactions = transactions.filter({ $0.type == type })
        var transactionsDictionary: [String:Double] = [:]
        
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = "dd.MM.yyyy"
        let calendar = Calendar.current
        
        
        for i in 0...days-1 {
            guard let dayBefore = calendar.date(byAdding: .day, value: -i, to: Date()) else { return [:] }
            let dayBeforeString = dateForamtter.string(from: dayBefore)
            transactionsDictionary[dayBeforeString] = 0
        }
        
        typeTransactions.forEach { transaction in
            
            let transactionDateString = dateForamtter.string(from: transaction.date)
            
            let savedValue = transactionsDictionary[transactionDateString]
            guard let transactionValue = Double(transaction.value) else { return }
            
            if let savedValue {
                transactionsDictionary[transactionDateString] = savedValue + transactionValue
            } else {
                transactionsDictionary[transactionDateString] = transactionValue
            }
        }
        return transactionsDictionary
    }
    
}

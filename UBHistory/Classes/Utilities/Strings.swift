//
//  Strings.swift
//  UBHistory
//
//  Created by Usemobile on 27/03/19.
//

import Foundation

extension String {
    
    static var stopType: String {
        switch currentLanguage {
        case .en:
            return "stop"
        case .pt:
            return "parada"
        case .es:
            return "parar"
        }
    }
    
    static var originType: String {
        switch currentLanguage {
        case .en:
            return "origin"
        case .pt:
            return "origem"
        case .es:
            return "origen"
        }
    }
    
    static var destinyType: String {
        switch currentLanguage {
        case .en:
            return "destiny"
        case .pt:
            return "destino"
        case .es:
            return "destino"
        }
    }
    
    static var emptyHistory: String {
        switch currentLanguage {
        case .en:
            return """
            You don't have
            any history
            """
        case .pt:
            return """
            Você ainda não tem
            nenhum histórico
            """
        case .es:
            return """
            Aún no lo tienes
            sin viaje
            """
        }
    }
    
    static var historyListFail: String {
        switch currentLanguage {
        case .en:
            return """
            It was not possible to list your history
            Wish to try again?
            """
        case .pt:
            return """
            Não foi possível listar seu histórico
            Deseja tentar novamente?
            """
        case .es:
            return """
            No se puede enumerar tu historial
            ¿Quieres intentarlo de nuevo?
            """
        }
    }
    
    static var retryTitle: String {
        switch currentLanguage {
        case .en:
            return "          Try again          "
        case .pt:
            return "          Tentar novamente          "
        case .es:
            return "          Intentarlo de nuevo       "
        }
    }
    
    static var notRatedText: String {
        switch currentLanguage {
        case .en:
            return "Not rated"
        case .pt:
            return "Não avaliado"
        case .es:
            return "No clasificado"
        }
    }
    
    static var cardPayment: String {
        switch currentLanguage {
        case .en:
            return "Card Payment"
        case .pt:
            return "Pagamento no Cartão"
        case .es:
            return "Pago con tarjeta"
        }
    }
    
    static var cashPayment: String {
        switch currentLanguage {
        case .en:
            return "Cash Payment"
        case .pt:
            return "Pagamento em Dinheiro"
        case .es:
            return "pago con dinero"
        }
    }
    
    static var driverUnavailable: String {
        return  .driver + " " + .unavailable
    }
    
    static var passengerUnavailable: String {
        return  .passenger + " " + .unavailable
    }
    
    static var rideNotAccepted: String {
        switch currentLanguage {
        case .en:
            return "Request was not accepted by a driver"
        case .pt:
            return "Corrida não foi aceita por um motorista"
        case .es:
            return "Corrida cancelada por el conductor"
        }
    }
    
    static var driver: String {
        switch currentLanguage{
        case .en:
            return "Driver"
        case .pt:
            return "Motorista"
        case .es:
            return "Conductor"
        }
    }
    
    static var passenger: String {
        switch currentLanguage{
        case .en:
            return "Passenger"
        case .pt:
            return "Passageiro"
        case .es:
            return "Pasajero"
        }
    }
    
    static var unavailable: String {
        switch currentLanguage {
        case .en:
            return "unavailable"
        case .pt:
            return "indisponível"
        case .es:
            return ""
        }
        
    }
    
    static var details: String {
        switch currentLanguage {
        case .en:
            return "DETAILS"
        case .pt:
            return "DETALHES"
        case .es:
            return "DETALLES"
        }
        
    }
    
    static var help: String {
        switch currentLanguage {
        case .en:
            return "HELP"
        case .pt:
            return "AJUDA"
        case .es:
            return "AYUDA"
        }
        
    }
    
    static var receipt: String {
        switch currentLanguage {
        case .en:
            return "RECEIPT"
        case .pt:
            return "RECIBO"
        case .es:
            return "FACTURA"
        }
        
    }
    
    static var travelValue: String {
        switch currentLanguage {
        case .en:
            return "TRAVEL VALUE"
        case .pt:
            return "VALOR DA CORRIDA"
        case .es:
            return "VALOR DE CARRERA"
        }
        
    }
    
    static var rated: String {
        switch currentLanguage {
        case .en:
            return "YOU RATED THE "
        case .pt:
            return "VOCÊ AVALIOU O "
        case .es:
            return "USTED CALIFICÓ AL"
        }
        
    }
    
    static var noRated: String {
        switch currentLanguage {
        case .en:
            return """
            You did not rate
            the
            """
        case .pt:
            return """
            Você não avaliou
            o
            """
        case .es:
            return """
            Usted no calificó
            al
            """
        }
        
    }
    
    static var origin: String {
        switch currentLanguage {
        case .en:
            return "origin"
        case .pt:
            return "origem"
        case .es:
            return "origen"
        }
        
    }
    
    static var destiny: String {
        switch currentLanguage {
        case .en:
            return "destiny"
        case .pt:
            return "destino"
        case .es:
            return "destino"
        }
        
    }
    
    static var stop: String {
        switch currentLanguage {
        case .en:
            return "stop"
        case .pt:
            return "parada"
        case .es:
            return "parar"
        }
        
    }
    
    static var dayAndHour: String {
        switch currentLanguage {
        case .en:
            return "day/time"
        case .pt:
            return "dia/horário"
        case .es:
            return "dia/hora"
        }
        
    }
    
    static var serviceOrder: String{
        switch currentLanguage {
        case .en:
            return "travel id"
        case .pt:
            return "id da viagem"
        case .es:
            return "id da viaje"
        }
    }
    
    static var distanceAndTime: String {
        switch currentLanguage {
        case .en:
            return "distance/duration"
        case .pt:
            return "distância/tempo"
        case .es:
            return "distância/tiempo"
        }
        
    }
    
    static var sendMessage: String {
        switch currentLanguage {
        case .en:
            return "Send message"
        case .pt:
            return "Enviar mensagem"
        case .es:
            return "Enviar mensaje"
        }
        
    }
    
    static var cash: String {
        switch currentLanguage {
        case .en:
            return "cash"
        case .pt:
            return "dinheiro"
        case .es:
            return "dinero"
        }
        
    }
    
    static var travelCancelledText: String {
        switch currentLanguage {
        case .en:
            return "Travel cancelled. Receipt unavailable"
        case .pt:
            return "Corrida cancelada. Recibo indisponível"
        case .es:
            return "Cancelado por el conductor"
        }
        
    }
    
    static var shareReceipt: String {
        switch currentLanguage {
        case .en:
            return "Share receipt"
        case .pt:
            return "Compartilhar recibo"
        case .es:
            return "Compartir factura"
        }
        
    }
    
    static var travelCost: String {
        switch currentLanguage {
        case .en:
            return "travel value"
        case .pt:
            return "valor da viagem"
        case .es:
            return "valor de carrera"
        }
        
    }
    
    static var travelFixedCost: String {
        switch currentLanguage {
        case .en:
            return "fixed cost"
        case .pt:
            return "custo fixo"
        case .es:
            return "costo fijo"
        }
        
    }
    
    static var travelTotalValue: String {
        switch currentLanguage {
        case .en:
            return "total value"
        case .pt:
            return "valor total"
        case .es:
            return "valor total"
        }
        
    }
    
    static var historyVCTitle: String {
        switch currentLanguage {
        case .en:
            return "Previous"
        case .pt:
            return "Anteriores"
        case .es:
            return "Atrás"
        }
        
    }
    
    static var historyDetailsVCTitle: String {
        switch currentLanguage {
        case .en:
            return "Travel details"
        case .pt:
            return "Detalhes da viagem"
        case .es:
            return "Detalles del viaje"
        }
    }
    
    static func cancelledByPassenger(language: HistoryLanguage) -> String {
        switch language {
        case .en:
            return """
            Cancelled
            by passenger
            """
        case .pt:
            return """
            Cancelada
            pelo passageiro
            """
        case .es:
            return """
            Cancelado
            por el pasajero
            """
        }
        
    }
    
    static func cancelledByDriver(language: HistoryLanguage) -> String {
        switch language {
        case .en:
            return """
            Cancelled
            by driver
            """
        case .pt:
            return """
            Cancelada
            pelo motorista
            """
        case .es:
            return """
            Cancelado
            por el conductor
            """
        }
        
    }
    
    static func cancelledBySystem(language: HistoryLanguage) -> String {
        switch language {
        case .en:
            return """
            Unmet
            Travel
            """
        case .pt:
            return """
            Viagem
            Não Atendida
            """
        case .es:
            return """
            No viajar
            respondió
            """
        }
        
    }
    
    static func cancelledByAdmin(language: HistoryLanguage) -> String {
        switch language {
        case .en:
            return """
            Cancelled
            by admin
            """
        case .pt:
            return """
            Cancelada
            pelo administrador
            """
        case .es:
            return """
            Cancelado
            por el administrador
            """
        }
        
    }
    
    static var invalidURL: String {
        switch currentLanguage {
        case .en:
            return "Invalid URL"
        case .pt:
            return "URL inválida"
        case .es:
            return "URL inválida"
        }
        
    }
    
    static var imageCastFail: String {
        switch currentLanguage {
        case .en:
            return "Image cast fail"
        case .pt:
            return "Falha ao receber imagem"
        case .es:
            return "Error al recibir la imagen"
        }
        
    }
    
    static var travels: String {
        switch currentLanguage {
        case .en:
            return "Travels"
        case .pt:
            return "Viagens"
        case .es:
            return "Historial"
        }
        
    }
    
    static var schedulesVCTitle: String {
        switch currentLanguage {
        case .en:
            return "Scheduled"
        case .pt:
            return "Agendadas"
        case .es:
            return "Programado"
        }
        
    }
    
    static var emptySchedules: String {
        switch currentLanguage {
        case .en:
            return """
            You don't have
            any scheduled travel
            """
        case .pt:
            return """
            Você ainda não tem
            nenhuma viagem agendada
            """
        case .es:
            return """
            Aún no lo tienes
            sin viaje programado
            """
        }
    }
    
    static var category: String {
        switch currentLanguage {
        case .en:
            return "CATEGORY"
        case .pt:
            return "CATEGORIA"
        case .es:
            return "CATEGORÍA"
        }
        
    }
    
    static var history: String {
        switch currentLanguage {
        case .en:
            return "History"
        case .pt:
            return "Histórico"
        case .es:
            return "Historia"
        }
        
    }
    
    //    static var model: String {
    //        switch currentLanguage {
    //        case .en:
    //            return ""
    //        case .pt:
    //            return ""
    //        }
    //
    //    }
    
}

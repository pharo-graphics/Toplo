Class {
	#name : #ToListDataSourceItemChangeUnanimityRequestEvent,
	#superclass : #ToUnanimityRequestEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListDataSourceItemChangeUnanimityRequestEvent >> sendTo: anObject [

	anObject listDataSourceItemsChangePreNotificationEvent: self
]

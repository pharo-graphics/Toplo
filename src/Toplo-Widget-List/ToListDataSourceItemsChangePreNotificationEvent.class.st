Class {
	#name : #ToListDataSourceItemsChangePreNotificationEvent,
	#superclass : #ToPreNotificationEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListDataSourceItemsChangePreNotificationEvent >> sendTo: anObject [

	anObject listDataSourceItemsChangePreNotificationEvent: self
]

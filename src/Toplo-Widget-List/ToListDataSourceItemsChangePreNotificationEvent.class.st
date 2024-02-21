Class {
	#name : #ToListDataSourceItemsChangePreNotificationEvent,
	#superclass : #ToListChangePreNotificationEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListDataSourceItemsChangePreNotificationEvent >> sendTo: anObject [

	anObject listDataSourceItemsChangePreNotificationEvent: self
]

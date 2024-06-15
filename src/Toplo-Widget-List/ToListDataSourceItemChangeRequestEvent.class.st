Class {
	#name : #ToListDataSourceItemChangeRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListDataSourceItemChangeRequestEvent >> sendTo: anObject [

	anObject listDataSourceItemsChangeRequestEvent: self
]

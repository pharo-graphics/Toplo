Class {
	#name : #ToListDataSourceItemChangeRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#instVars : [
		'dataSourceEvent'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListDataSourceItemChangeRequestEvent >> dataSourceEvent [

	^ dataSourceEvent
]

{ #category : #accessing }
ToListDataSourceItemChangeRequestEvent >> dataSourceEvent: anObject [

	dataSourceEvent := anObject
]

{ #category : #sending }
ToListDataSourceItemChangeRequestEvent >> sendTo: anObject [

	anObject listDataSourceItemsChangeRequestEvent: self
]

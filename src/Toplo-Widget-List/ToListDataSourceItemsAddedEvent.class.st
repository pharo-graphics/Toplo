Class {
	#name : #ToListDataSourceItemsAddedEvent,
	#superclass : #ToListDataSourceItemsChangeEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListDataSourceItemsAddedEvent >> sendTo: anObject [

	anObject listDataSourceItemsAddedEvent: self
]

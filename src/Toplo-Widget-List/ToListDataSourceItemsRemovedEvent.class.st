Class {
	#name : #ToListDataSourceItemsRemovedEvent,
	#superclass : #ToListDataSourceItemsChangeEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListDataSourceItemsRemovedEvent >> sendTo: anObject [

	anObject listDataSourceItemsRemovedEvent: self
]

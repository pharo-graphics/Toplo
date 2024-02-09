Class {
	#name : #ToListNodeSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'events handling' }
ToListNodeSelectionEventHandler >> clickEvent: anEvent [

	| listElement node |
	node := anEvent currentTarget.
	listElement := node holder listElement.

	node dispatchEvent: (ToListClickOnNodeEvent new
			 listElement: listElement;
			 sourceEvent: anEvent;
			 yourself)
]

{ #category : #'api - accessing' }
ToListNodeSelectionEventHandler >> eventsToHandle [

	^ { ToListClickOnNodeEvent. ToListDoubleClickOnNodeEvent. BlPrimaryClickEvent  }
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> listClickOnNodeEvent: anEvent [

	self subclassResponsibility
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> listDoubleClickOnNodeEvent: anEvent [

	anEvent listElement dispatchEvent: (ToListStrongSelectionEvent new
			 indexes: anEvent listElement selectionModel selectedIndexes;
			 yourself)
]

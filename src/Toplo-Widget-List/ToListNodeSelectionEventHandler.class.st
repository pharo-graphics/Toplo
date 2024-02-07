Class {
	#name : #ToListNodeSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'api - accessing' }
ToListNodeSelectionEventHandler >> eventsToHandle [

	^ { ToListClickOnNodeEvent. ToListDoubleClickOnNodeEvent }
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> listClickOnNodeEvent: anEvent [

	self subclassResponsibility
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> listDoubleClickOnNodeEvent: anEvent [

	anEvent listElement dispatchEvent: ToListStrongSelectionEvent new
]

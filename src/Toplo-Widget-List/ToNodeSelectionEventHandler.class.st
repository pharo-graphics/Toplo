Class {
	#name : #ToNodeSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'api - accessing' }
ToNodeSelectionEventHandler >> eventsToHandle [

	^ { ToNodeAttachementEvent }
]

{ #category : #'event handlers' }
ToNodeSelectionEventHandler >> nodeAttachementEvent: anEvent [

	anEvent attached ifFalse: [ 
		anEvent currentTarget removeEventHandler: self ]
]

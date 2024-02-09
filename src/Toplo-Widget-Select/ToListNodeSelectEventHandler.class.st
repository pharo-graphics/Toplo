Class {
	#name : #ToListNodeSelectEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #'api - accessing' }
ToListNodeSelectEventHandler >> eventsToHandle [

	"^ {  BlPrimaryClickEvent. ToListClickOnNodeEvent. BlPrimaryMouseDownEvent }"
	^ super eventsToHandle
]

{ #category : #'mouse handlers' }
ToListNodeSelectEventHandler >> listClickOnNodeEvent: anEvent [

	anEvent listElement selectionMode
		onClickOnNode: anEvent currentTarget
		event: anEvent.
	anEvent consumed: true
]

{ #category : #'mouse handlers' }
ToListNodeSelectEventHandler >> mouseDownEvent: anEvent [

	anEvent
		ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'mouse handlers' }
ToListNodeSelectEventHandler >> primaryMouseDownEvent: anEvent [

	| index target node |
	
		"index := node holder position.
		target := anEvent listElement.
		(target selectionModel containsIndex: index)
			ifTrue: [ self selecter deselectIndex: index ]
			ifFalse: [ self selecter selectIndex: index ]."
]

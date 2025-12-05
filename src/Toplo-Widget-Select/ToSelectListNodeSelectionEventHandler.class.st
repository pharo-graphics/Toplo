Class {
	#name : #ToSelectListNodeSelectionEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'mouse handlers' }
ToSelectListNodeSelectionEventHandler >> clickEvent: anEvent [

	
]

{ #category : #'api - accessing' }
ToSelectListNodeSelectionEventHandler >> eventsToHandle [

	^ super eventsToHandle , { BlMouseUpEvent }
]

{ #category : #'mouse handlers' }
ToSelectListNodeSelectionEventHandler >> mouseUpEvent: anEvent [

	anEvent
		  ifPrimary: [ self pickEvent: anEvent ]
		  secondary: [  ]
		  middle: [  ]
		  other: [  ]
]

Class {
	#name : #ToSelectPopupListNodeSelectionEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'mouse handlers' }
ToSelectPopupListNodeSelectionEventHandler >> clickEvent: anEvent [

	
]

{ #category : #'api - accessing' }
ToSelectPopupListNodeSelectionEventHandler >> eventsToHandle [

	^ super eventsToHandle , { BlMouseUpEvent }
]

{ #category : #'mouse handlers' }
ToSelectPopupListNodeSelectionEventHandler >> mouseUpEvent: anEvent [

	anEvent
		  ifPrimary: [ self pickEvent: anEvent ]
		  secondary: [  ]
		  middle: [  ]
		  other: [  ]
]

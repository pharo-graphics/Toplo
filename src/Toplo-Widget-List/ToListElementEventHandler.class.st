Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'data events handling' }
ToListElementEventHandler >> collectionEmptinessEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'element events handling' }
ToListElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  BlMouseDownEvent.
		  " data events "
		  ToCollectionEmptinessEvent  }
]

{ #category : #'mouse handlers' }
ToListElementEventHandler >> mouseDownEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target requestFocusOnMouseDown ifFalse: [ ^ self ].
	target hasFocus ifTrue: [ ^ self ].
	target requestFocus.
	anEvent consumed: true
]

{ #category : #'data events handling' }
ToListElementEventHandler >> showHidePlaceholderIn: aListElement [

	aListElement data ifEmpty: [ ^ aListElement showPlaceholder ].
	aListElement hidePlaceholder
]

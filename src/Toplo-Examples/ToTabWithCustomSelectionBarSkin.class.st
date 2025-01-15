Class {
	#name : #ToTabWithCustomSelectionBarSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'event handling' }
ToTabWithCustomSelectionBarSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e childWithId: #selectionBar ifNone: [
			e whenLayoutedDoOnce: [
				| bar |
				bar := BlElement new background: e selectedBackground.
				bar width: e measuredWidth.
				bar height: 3.
				bar constraintsDo: [ :c |
					c ignoreByLayout.
					c ignored horizontal alignLeft.
					c ignored vertical alignBottom ].
				bar id: #selectionBar.
				e addChild: bar ] ] ]
]

{ #category : #'event handling' }
ToTabWithCustomSelectionBarSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e |
		e mouseCursor: Cursor webLink.
		e background: e hoveredBackground. ]
]

{ #category : #'event handling' }
ToTabWithCustomSelectionBarSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e border: BlBorder empty.
		e background: BlBackground transparent.
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-VXS')
				 left: (e valueOfTokenNamed: #'padding-content-H')
				 bottom: (e valueOfTokenNamed: #'padding-content-VXS')
				 right: (e valueOfTokenNamed: #'padding-content-H')).
		e geometry: e defaultGeometry ]
]

{ #category : #'event handling' }
ToTabWithCustomSelectionBarSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e background: BlBackground transparent ].

]

{ #category : #'event handling' }
ToTabWithCustomSelectionBarSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| bar |
		bar := e childWithId: #selectionBar ifNone: [  ].
		bar ifNotNil: [ bar removeFromParent ] ]
]

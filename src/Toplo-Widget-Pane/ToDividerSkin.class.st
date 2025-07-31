Class {
	#name : #ToDividerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'event handling' }
ToDividerSkin >> dragStartedSkinEvent: anEvent [

	super dragStartedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: e resizerCursor.
		e border: e defaultBorder.
		e background: e defaultBackground  ]
]

{ #category : #'event handling' }
ToDividerSkin >> draggedSkinEvent: anEvent [

	super draggedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: e resizerCursor ]
]

{ #category : #'event handling' }
ToDividerSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
			e mouseCursor: e resizerCursor.
			e border: e hoveredBorder.
			e background: e hoveredBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> innerImageIn: aDivider [

	^ aDivider isHorizontal
		  ifTrue: [
		  ToMaterialDesignIconProvider innerImageNamed: 'outlined_morehoriz' ]
		  ifFalse: [
		  ToMaterialDesignIconProvider innerImageNamed: 'outlined_morevert' ]
]

{ #category : #'event handling' }
ToDividerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| im |
			e border: e defaultBorder.
			e background: e defaultBackground.
			im := ToImage inner: (self innerImageIn: e).
			im extent: 30 asPoint.
			im innerImageColor: e pressedBackground.
			e addChild: im.
			im constraintsDo: [ :c |
					c ignoreByLayout.
					e isHorizontal
						ifTrue: [
								c anchors add: (c anchors verticalCenterAnchor on:
										 c anchors parent verticalCenterAnchor).
								c anchors add:
									(c anchors horizontalCenterAnchor on: c anchors parent horizontalCenterAnchor) ]
						ifFalse: [
								c anchors add: (c anchors horizontalCenterAnchor on:
										 c anchors parent horizontalCenterAnchor).
								c anchors add:
									(c anchors verticalCenterAnchor on: c anchors parent verticalCenterAnchor) ] ] ]
]

{ #category : #'event handling' }
ToDividerSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: e defaultBorder.
		e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		self flag: 'TODO: see issue #298'.
		"e mouseCursor: e resizerCursor.
		e border: e pressedBorder.
		e background: e pressedBackground" ]
]

{ #category : #'event handling' }
ToDividerSkin >> releasedSkinEvent: anEvent [

	super releasedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		self flag: 'TODO: see issue #298'.
		"e mouseCursor: Cursor normal.
		e border: e defaultBorder.
		e background: e defaultBackground" ]
]

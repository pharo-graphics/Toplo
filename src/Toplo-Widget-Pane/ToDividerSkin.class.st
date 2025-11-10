Class {
	#name : #ToDividerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'event handling' }
ToDividerSkin >> dragEndedSkinEvent: anEvent [

	super dragEndedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
			e mouseCursor: (self resizerCursorIn: e).
			e background: (e valueOfTokenNamed: #'divider-hovered-background') ]
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
			e geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
			e background: e defaultBackground.
			e childWithId: #gripImage ifFound: [ :f | f removeFromParent ].
			im := ToImage inner: (self innerImageIn: e).
			im id: #gripImage.
			im extent: (e valueOfTokenNamed: #'divider-image-size') asPoint.
			im innerImageColor:
				(e valueOfTokenNamed: #'divider-hovered-background').
			e addChild: im.
			im constraintsDo: [ :c |
					c ignoreByLayout.
					e isHorizontal
						ifTrue: [
								c anchors add: (c anchors verticalCenterAnchor on:
										 c anchors parent verticalCenterAnchor).
								c anchors add: (c anchors horizontalCenterAnchor on:
										 c anchors parent horizontalCenterAnchor) ]
						ifFalse: [
								c anchors add: (c anchors horizontalCenterAnchor on:
										 c anchors parent horizontalCenterAnchor).
								c anchors add: (c anchors verticalCenterAnchor on:
										 c anchors parent verticalCenterAnchor) ] ] ]
]

{ #category : #'event handling' }
ToDividerSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'divider-pressed-background') ]
]

{ #category : #'event handling' }
ToDividerSkin >> releasedSkinEvent: anEvent [

	super releasedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e defaultBackground ]
]

{ #category : #accessing }
ToDividerSkin >> resizerCursorIn: aDivider [

	^ aDivider isHorizontal
		  ifTrue: [ Cursor resizeTop ]
		  ifFalse: [ Cursor resizeRight ]
]

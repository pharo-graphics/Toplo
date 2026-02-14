Class {
	#name : #MyCircularMenuItemSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-NotUsed'
}

{ #category : #'event handling' }
MyCircularMenuItemSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent traceCr.
	anEvent elementDo: [ :e |
			e childWithId: #itemBackground ifFound: [ :b |
				b innerImageColor: (e valueOfTokenNamed: #'color-primary-hover') ] ]
]

{ #category : #'event handling' }
MyCircularMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent traceCr.
	anEvent elementDo: [ :e |
			| newSize background |
			background := ToImage inner: MyCircularMenuItem menuItemSvg.
			background id: #itemBackground.
			background extent: 75 asPoint.
			background innerImageColor: (e valueOfTokenNamed: #'color-primary').
			background constraintsDo: [ :c | c ignoreByLayout ].
			e addChildFirst: background.
			e alignCenter: true.
			"Icon"
			newSize := 24 asPoint.
			e hasIcon & e hasLabel not ifTrue: [ newSize := 26 asPoint ].
			e hasIcon ifTrue: [
					self resizeImage: e icon innerImageTo: newSize.
					e icon extent: 75 asPoint.
					e icon innerImageColor: Color white ] ]
]

{ #category : #'event handling' }
MyCircularMenuItemSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e
				childWithId: #itemBackground
				ifFound: [ :b |
				b innerImageColor: (e valueOfTokenNamed: #'color-primary') ] ]
]

{ #category : #'event handling' }
MyCircularMenuItemSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e childWithId: #itemBackground ifFound: [ :b |
				b innerImageColor: (e valueOfTokenNamed: #'color-primary-pressed') ] ]
]

{ #category : #'event handling' }
MyCircularMenuItemSkin >> releasedSkinEvent: anEvent [

	super releasedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e childWithId: #itemBackground ifFound: [ :b |
				b innerImageColor: (e valueOfTokenNamed: #'color-primary-hover') ] ]
]

{ #category : #private }
MyCircularMenuItemSkin >> resizeImage: anImage innerImageTo: aSize [

	anImage
		withInnerFormDo: [ :f |
				| formExtent newScale |
				formExtent := f extent = 0 asPoint
					              ifTrue: [ 1 asPoint ]
					              ifFalse: [ f extent ].
				newScale := aSize / formExtent.
				anImage innerImage: (f magnifyBy: (newScale x max: newScale y)) ]
		ifNone: [ ].
	anImage
		withInnerSvgElementDo: [ :f |
				anImage extent: aSize asPoint.
				f extent: aSize asPoint ]
		ifNone: [ ]
]

Class {
	#name : #ToClickableSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'cursorLook',
		'sizing',
		'shaping'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'private - shaping' }
ToClickableSkin >> applyCircleShapingOn: anElement [

	anElement spacingWidth: 0.
	anElement padding: BlInsets empty.
	anElement skinDo: [ :s |
		anElement size: (s sizing heightOn: anElement) asPoint ].
	anElement geometry: BlCircleGeometry new.
	anElement layout: BlFrameLayout new.
]

{ #category : #'private - shaping' }
ToClickableSkin >> applyDefaultShapingOn: anElement [

	| radius |
	self applyRectShapingOn: anElement.
	anElement skinDo: [ :s |
		radius := s sizing shapingRadiusIn: anElement.
		anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius) ]
	

]

{ #category : #'private - shaping' }
ToClickableSkin >> applyRectShapingOn: anElement [

	anElement layout: BlLinearLayout new.
	anElement hFitContent.
	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal).
]

{ #category : #'private - shaping' }
ToClickableSkin >> applyRoundShapingOn: anElement [

	| radius |
	self applyRectShapingOn: anElement.	
	radius := anElement requestedHeight / 2.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]

{ #category : #accessing }
ToClickableSkin >> changeShapingWith: aControlShaping in: anElement [

	self shaping: aControlShaping.
	self dispatchChangedEventIn: anElement
]

{ #category : #accessing }
ToClickableSkin >> changeSizingWith: aControlSizing in: anElement [

	self sizing: aControlSizing.
	self dispatchChangedEventIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToClickableSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	cursorLook := ToMouseCursorLook new.
	cursorLook hoverCursor: [ :but | but isEnabled ifTrue: [ BlCursor hand ] ifFalse: []].
	self addLook: cursorLook.
	" shape depends on the size so sizing is applied first "
	self sizing applyOn: anElement.
	self shaping applyOn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToClickableSkin >> onSkinUninstalledIn: anElement [

	self removeLook: cursorLook.
	super onSkinUninstalledIn: anElement
]

{ #category : #accessing }
ToClickableSkin >> shaping [
	" CircleShaping | RoundShaping | DefaultShaping "

	^ shaping ifNil: [ shaping := ToDefaultShaping new ]
]

{ #category : #accessing }
ToClickableSkin >> shaping: aControlShaping [

	" CircleShaping | RoundShaping | DefaultShaping "
	shaping := aControlShaping
]

{ #category : #accessing }
ToClickableSkin >> sizing [
	" LargeSizing | MiddleSizing (default) | SmallSizing "

	^ sizing ifNil: [ sizing := ToMiddleSizing new ]
]

{ #category : #accessing }
ToClickableSkin >> sizing: aControlSizing [

	" LargeSizing | MiddleSizing (default) | SmallSizing "
	sizing := aControlSizing
]

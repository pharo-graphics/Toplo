Class {
	#name : #ToControlSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'cursorLook',
		'sizing',
		'shaping'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #accessing }
ToControlSkin >> changeShapingWith: aControlShaping in: anElement [

	self shaping: aControlShaping.
	self dispatchChangedEventIn: anElement
]

{ #category : #accessing }
ToControlSkin >> changeSizingWith: aControlSizing in: anElement [

	self sizing: aControlSizing.
	self dispatchChangedEventIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToControlSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	cursorLook := ToMouseCursorLook new.
	cursorLook hoverCursor: [ :but | but isEnabled ifTrue: [ BlCursor hand ] ifFalse: []].
	self addLook: cursorLook.
	" shape depends on the size so sizing is applied first "
	self sizing applyOn: anElement.
	self shaping applyOn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToControlSkin >> onSkinUninstalledIn: anElement [

	self removeLook: cursorLook.
	super onSkinUninstalledIn: anElement
]

{ #category : #accessing }
ToControlSkin >> shaping [
	" CircleShaping | RoundShaping | DefaultShaping "

	^ shaping ifNil: [ shaping := ToDefaultShaping new ]
]

{ #category : #accessing }
ToControlSkin >> shaping: aControlShaping [

	" CircleShaping | RoundShaping | DefaultShaping "
	shaping := aControlShaping
]

{ #category : #accessing }
ToControlSkin >> sizing [
	" LargeSizing | MiddleSizing (default) | SmallSizing "

	^ sizing ifNil: [ sizing := ToMiddleSizing new ]
]

{ #category : #accessing }
ToControlSkin >> sizing: aControlSizing [

	" LargeSizing | MiddleSizing (default) | SmallSizing "
	sizing := aControlSizing
]

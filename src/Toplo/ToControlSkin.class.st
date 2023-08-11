Class {
	#name : #ToControlSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'cursorLook',
		'sizing'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #accessing }
ToControlSkin >> changeSizingWith: aSymbol in: anElement [

	self sizing: aSymbol.
	self dispatchChangedEventIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToControlSkin >> initializeSizeIn: anElement [

	self sizing = #middle ifTrue: [
		^ anElement height: anElement toTheme controlHeight ].
	self sizing = #large ifTrue: [
		^ anElement height: anElement toTheme controlHeightLG ].
	anElement height: anElement toTheme controlHeightSM
]

{ #category : #'api - install/uninstall  hook' }
ToControlSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	cursorLook := ToMouseCursorLook new.
	cursorLook hoverCursor: [ :but | but isEnabled ifTrue: [ BlCursor hand ] ifFalse: []].
	self addLook: cursorLook.
	self initializeSizeIn: anElement.


]

{ #category : #'api - install/uninstall  hook' }
ToControlSkin >> onSkinUninstalledIn: anElement [

	self removeLook: cursorLook.
	super onSkinUninstalledIn: anElement
]

{ #category : #accessing }
ToControlSkin >> sizing [

	" large | middle (default) | small "
	^ sizing ifNil: [ sizing := #middle ]
]

{ #category : #accessing }
ToControlSkin >> sizing: aSymbol [

	" large | middle (default) | small "
	sizing := aSymbol
]

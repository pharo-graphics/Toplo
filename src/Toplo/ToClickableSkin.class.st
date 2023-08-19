Class {
	#name : #ToClickableSkin,
	#superclass : #ToWidgetSkin,
	#classTraits : 'TToReshapeableWidgetSkin classTrait',
	#instVars : [
		'cursorLook'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'private - shaping/sizing' }
ToClickableSkin >> applyRectShaping: aShaping on: anElement [

	(anElement layout isKindOf: BlLinearLayout) ifFalse: [ 
		anElement layout: BlLinearLayout new]. 
	anElement verticalRequested
		ifTrue: [
			anElement vFitContent.
			anElement spacingHeight: anElement toTheme paddingContentVertical / 2 ]
		ifFalse: [
			anElement hFitContent.
			anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2 ].
		
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal)
]

{ #category : #'api - install/uninstall  hook' }
ToClickableSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	cursorLook := ToMouseCursorLook new.
	cursorLook hoverCursor: [ :but | but isEnabled ifTrue: [ BlCursor hand ] ifFalse: []].
	self addLook: cursorLook
]

{ #category : #'api - install/uninstall  hook' }
ToClickableSkin >> onSkinUninstalledIn: anElement [

	self removeLook: cursorLook.
	super onSkinUninstalledIn: anElement
]

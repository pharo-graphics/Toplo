Class {
	#name : #ToLabelSkin,
	#superclass : #ToBasicLabelSkin,
	#instVars : [
		'type',
		'heading'
	],
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToLabelSkin >> heading [

	^ heading
]

{ #category : #accessing }
ToLabelSkin >> heading: anObject [

	heading := anObject
]

{ #category : #initialization }
ToLabelSkin >> initialize [

	super initialize.
	type := ToLabelDefaultType new.
	heading := ToTextH0 new
]

{ #category : #accessing }
ToLabelSkin >> labelLookIn: anElement [

	| labelLook |
	labelLook := ToLabelTextLook new.
	labelLook
		initialColor: (self type textColorIn: anElement).
	^ labelLook
]

{ #category : #'api - install/uninstall  hook' }
ToLabelSkin >> onSkinInstalledIn: anElement [

	| labelLook attrBuilder |
	super onSkinInstalledIn: anElement.
	attrBuilder := self textAttributesBuilderFromElement: anElement.
	labelLook := self labelLookIn: anElement.
	labelLook attrBuilder: attrBuilder.
	self addLook: labelLook.



]

{ #category : #accessing }
ToLabelSkin >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := super textAttributesBuilderFromElement: anElement.
	builder lineSpacing: (self heading lineHeightIn: anElement).
	builder defaultFontSize: (self heading fontSizeIn: anElement).
	builder foreground: (self type textColorIn: anElement).

	^ builder 
]

{ #category : #accessing }
ToLabelSkin >> type [

	^ type
]

{ #category : #accessing }
ToLabelSkin >> type: aLabelType [

	type := aLabelType
]

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

	^ ToLabelTextLook new
		  weight: anElement toTheme fontWeightStrong;
		  defaultFontName: anElement toTheme fontFamilyCode;
		  defaultFontSize: (self heading fontSizeIn: anElement);
		  lineSpacing: (self heading lineHeightIn: anElement);
		  foreground: (self type textColorIn: anElement);
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [:e | self type textColorIn: anElement ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToLabelSkin >> onSkinInstalledIn: anElement [

	| labelLook  |
	super onSkinInstalledIn: anElement.
	labelLook := self labelLookIn: anElement.
	self addLook: labelLook.



]

{ #category : #accessing }
ToLabelSkin >> type [

	^ type
]

{ #category : #accessing }
ToLabelSkin >> type: aLabelType [

	type := aLabelType
]

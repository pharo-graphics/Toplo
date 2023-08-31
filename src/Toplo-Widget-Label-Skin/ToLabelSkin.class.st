Class {
	#name : #ToLabelSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'heading',
		'type'
	],
	#category : #'Toplo-Widget-Label-Skin'
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

	super onSkinInstalledIn: anElement.
	self addLook: (self labelLookIn: anElement).



]

{ #category : #accessing }
ToLabelSkin >> type [

	^ type
]

{ #category : #accessing }
ToLabelSkin >> type: aLabelType [

	type := aLabelType
]

Class {
	#name : #ToLabelSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'heading',
		'type'
	],
	#category : #'Toplo-Widget-Album-Skin'
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

	| prop attrBuilder |
	prop := ToExplicitPropertyDef new name: #'text-attributes'.
	prop writer: [ :e :v |
		e text attributes: v attributes.
		e textChanged ].
	attrBuilder := BlTextAttributesBuilder new
		               weight: anElement toTheme fontWeightStrong;
		               defaultFontName: anElement toTheme fontFamilyCode;
		               defaultFontSize: (self heading fontSizeIn: anElement);
		               lineSpacing: (self heading lineHeightIn: anElement);
		               foreground: (self type textColorIn: anElement);
		               yourself.
	^ (ToLookUpdater new property: prop)
		  when: ToDisabledLookEvent value: (attrBuilder
				   foreground: anElement toTheme colorTextDisabled;
				   yourself);
		  when: ToInitialLookEvent value: (attrBuilder
			   foreground: (self type textColorIn: anElement);
			   yourself);
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

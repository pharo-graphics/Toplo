Class {
	#name : #ToLabelSkin,
	#superclass : #ToWidgetSkinDep,
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

	^ (anElement styleSheet newLookUpdaterForPropertyName: #'text-attributes-with-builder')
		  when: ToInstallLookEvent value: (BlTextAttributesBuilder new
					weight: anElement toTheme fontWeightStrong;
		         defaultFontName: anElement toTheme fontFamilyCode;
					defaultFontSize: (self heading fontSizeIn: anElement);
					lineSpacing: (self heading lineHeightIn: anElement);
			   		yourself);		  
			when: ToDisabledLookEvent value: [:e | BlTextAttributesBuilder new
				   foreground: anElement toTheme colorTextDisabled ];
				   yourself;
		  when: ToInitialLookEvent value: [:e | BlTextAttributesBuilder new
			   foreground: (self type textColorIn: anElement)];
			   yourself;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToLabelSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLookUpdater: (self labelLookIn: anElement).



]

{ #category : #accessing }
ToLabelSkin >> type [

	^ type
]

{ #category : #accessing }
ToLabelSkin >> type: aLabelType [

	type := aLabelType
]

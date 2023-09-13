Class {
	#name : #ToButtonIconSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'danger'
	],
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #private }
ToButtonIconSkin >> adaptForegroundIn: aToImage withColor: aColor [

	aToImage
		withInnerFormDo: [ :form |
			| newForm |
			newForm := form collectColors: [ :color | aColor alpha: color alpha ].
			aToImage innerImage: newForm ]
		ifNone: [  ]
]

{ #category : #accessing }
ToButtonIconSkin >> danger [

	^ danger ifNil: [ danger := false ]
]

{ #category : #accessing }
ToButtonIconSkin >> danger: aBoolean [

	danger := aBoolean
]

{ #category : #'api - install/uninstall  hook' }
ToButtonIconSkin >> dangerFormLookIn: anElement [

	^ ToLookUpdater new 
		property: (ToPseudoProperty new 
			name: #'form-foreground'; 
			writer: [ :e :v | self adaptForegroundIn: e withColor: v] );
		when: ToDisabledLookEvent value: [ :e | e toTheme colorImageDisabled ];
		when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
		when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
		when: ToPressedLookEvent value: [ :e | e toTheme colorError darker ];
		yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonIconSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLookUpdater: (self danger
			 ifTrue: [ self dangerFormLookIn: anElement ]
			 ifFalse: [ self regularFormLookIn: anElement ])
]

{ #category : #'api - install/uninstall  hook' }
ToButtonIconSkin >> regularFormLookIn: anElement [

	^ self subclassResponsibility 
]

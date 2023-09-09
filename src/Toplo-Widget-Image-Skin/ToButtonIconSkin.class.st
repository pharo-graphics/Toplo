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

	^ ToLook new
		  applyWith: [ :e :v | self adaptForegroundIn: e withColor: v ];
		  whenDisabled: [ :e | e toTheme colorImageDisabled ];
		  whenInitialized: [ :e | e toTheme colorError ];
		  whenHovered: [ :e | e toTheme colorErrorHover ];
		  whenPressed: [ :e | e toTheme colorError darker ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonIconSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (self danger
			 ifTrue: [ self dangerFormLookIn: anElement ]
			 ifFalse: [ self regularFormLookIn: anElement ])
]

{ #category : #'api - install/uninstall  hook' }
ToButtonIconSkin >> regularFormLookIn: anElement [

	^ self subclassResponsibility 
]

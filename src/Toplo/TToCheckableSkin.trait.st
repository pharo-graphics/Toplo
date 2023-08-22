Trait {
	#name : #TToCheckableSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'t - checkable - install/uninstall  hook' }
TToCheckableSkin >> backgroundLookIn: anElement [

	^ self type checkableButtonBackgroundLookIn: anElement
]

{ #category : #'t - checkable - install/uninstall  hook' }
TToCheckableSkin >> borderLookIn: anElement [

	^ self type checkableButtonBorderLookIn: anElement
]

{ #category : #accessing }
TToCheckableSkin >> checkedImageIn: anElement [

	^ self explicitRequirement 
]

{ #category : #accessing }
TToCheckableSkin >> disabledImageIn: anElement [

	^ self explicitRequirement 
]

{ #category : #accessing }
TToCheckableSkin >> iconSkinIn: aButton [ 

	^ self explicitRequirement 

]

{ #category : #accessing }
TToCheckableSkin >> indeterminateImageIn: anElement [

	^ self explicitRequirement 
]

{ #category : #accessing }
TToCheckableSkin >> labelSkinIn: aButton [

	^ self type checkableLabelSkinIn: aButton

]

{ #category : #'t - checkable - install/uninstall  hook' }
TToCheckableSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (ToCheckLook new
			 disabledImage: (self disabledImageIn: anElement);
			 checkedImage: (self checkedImageIn: anElement);
			 uncheckedImage: (self uncheckedImageIn: anElement);
			 indeterminateImage: (self indeterminateImageIn: anElement);
			 yourself)
]

{ #category : #accessing }
TToCheckableSkin >> uncheckedImageIn: anElement [

	^ self explicitRequirement 
]

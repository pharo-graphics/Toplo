Trait {
	#name : #TToRadioButtonSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'t - checkable skin - accessing images' }
TToRadioButtonSkin >> checkedImageIn: anElement [

	^ anElement toTheme radioCheckedImageIn: anElement
]

{ #category : #'t - checkable skin - accessing images' }
TToRadioButtonSkin >> disabledImageIn: anElement [

	^ anElement toTheme radioDisabledImageIn: anElement
]

{ #category : #'t - checkable skin - accessing images' }
TToRadioButtonSkin >> indeterminateImageIn: anElement [

	^ anElement toTheme radioIndeterminateImageIn: anElement
]

{ #category : #'t - checkable skin - accessing images' }
TToRadioButtonSkin >> uncheckedImageIn: anElement [

	^ anElement toTheme radioUncheckedImageIn: anElement
]

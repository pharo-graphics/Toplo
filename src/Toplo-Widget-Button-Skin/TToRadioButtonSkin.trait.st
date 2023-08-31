Trait {
	#name : #TToRadioButtonSkin,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'t - checkable skin - accessing images' }
TToRadioButtonSkin >> checkedImageIn: anElement [

	^ anElement checkedImage ifNil: [ anElement toTheme radioCheckedImageIn: anElement ]
]

{ #category : #'t - checkable skin - accessing images' }
TToRadioButtonSkin >> disabledImageIn: anElement [

	^ anElement disabledImage ifNil: [ anElement toTheme radioDisabledImageIn: anElement ]
]

{ #category : #'t - checkable skin - accessing images' }
TToRadioButtonSkin >> indeterminateImageIn: anElement [

	^ anElement indeterminateImage ifNil: [ anElement toTheme radioIndeterminateImageIn: anElement ]
]

{ #category : #'t - checkable skin - accessing images' }
TToRadioButtonSkin >> uncheckedImageIn: anElement [

	^ anElement uncheckedImage ifNil: [ anElement toTheme radioUncheckedImageIn: anElement ]
]

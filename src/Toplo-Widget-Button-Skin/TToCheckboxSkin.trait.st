Trait {
	#name : #TToCheckboxSkin,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'t - checkable skin - accessing images' }
TToCheckboxSkin >> checkedImageIn: anElement [

	^ anElement checkedImage ifNil: [ anElement toTheme checkboxCheckedImageIn: anElement ]
]

{ #category : #'t - checkable skin - accessing images' }
TToCheckboxSkin >> disabledImageIn: anElement [

	^ anElement disabledImage ifNil: [ anElement toTheme checkboxDisabledImageIn: anElement ]
]

{ #category : #'t - checkable skin - accessing images' }
TToCheckboxSkin >> indeterminateImageIn: anElement [

	^ anElement indeterminateImage ifNil: [anElement toTheme checkboxIndeterminateImageIn: anElement ]
]

{ #category : #'t - checkable skin - accessing images' }
TToCheckboxSkin >> uncheckedImageIn: anElement [

	^ anElement uncheckedImage ifNil: [ anElement toTheme checkboxUncheckedImageIn: anElement ]
]

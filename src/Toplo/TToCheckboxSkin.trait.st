Trait {
	#name : #TToCheckboxSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'t - checkable skin - accessing images' }
TToCheckboxSkin >> checkedImageIn: anElement [

	^ anElement toTheme checkboxCheckedImageIn: anElement
]

{ #category : #'t - checkable skin - accessing images' }
TToCheckboxSkin >> disabledImageIn: anElement [

	^ anElement toTheme checkboxDisabledImageIn: anElement
]

{ #category : #'t - checkable skin - accessing images' }
TToCheckboxSkin >> indeterminateImageIn: anElement [

	^ anElement toTheme checkboxIndeterminateImageIn: anElement
]

{ #category : #'t - checkable skin - accessing images' }
TToCheckboxSkin >> uncheckedImageIn: anElement [

	^ anElement toTheme checkboxUncheckedImageIn: anElement
]

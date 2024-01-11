Extension { #name : #ToRawTheme }

{ #category : #'*Toplo-IDE' }
ToRawTheme >> inspectionTheme [

	^ SpLabelPresenter new label: 'I am a ToRawTheme'; yourself.
]

{ #category : #'*Toplo-IDE' }
ToRawTheme >> inspectionThemeForElement [

	^ ToSkinThemeSpec new
]

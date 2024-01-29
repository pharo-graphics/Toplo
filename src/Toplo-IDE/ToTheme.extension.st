Extension { #name : #ToTheme }

{ #category : #'*Toplo-IDE' }
ToTheme >> inspectionTheme [

	^ self shouldBeImplemented 
]

{ #category : #'*Toplo-IDE' }
ToTheme >> specializationPresenter [

	^ ToDefaultThemeSpecializationPresenter new
]

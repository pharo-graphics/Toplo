Extension { #name : #ToTheme }

{ #category : #'*Toplo-IDE' }
ToTheme >> inspectionTheme [

	^ self shouldBeImplemented 
]

{ #category : #'*Toplo-IDE' }
ToTheme >> inspectionThemeWithSkin [

	^ (ToLabelPresenter new
				   label: 'I am a ', self class name, '.';
				   yourself)
]

{ #category : #'*Toplo-IDE' }
ToTheme >> inspectorColumnsListFor: aToSpaceThemeElementListSpec [

	^ aToSpaceThemeElementListSpec defaultColumns
]

{ #category : #'*Toplo-IDE' }
ToTheme >> spaceThemeStrategyFor: aSpecPresenter [

	^ ToSpaceThemeWithThemeStrategy new theme: self; yourself
]

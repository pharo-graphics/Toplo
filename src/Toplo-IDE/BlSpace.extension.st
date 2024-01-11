Extension { #name : #BlSpace }

{ #category : #'*Toplo-IDE' }
BlSpace >> inspectionTheme [

	<inspectorPresentationOrder: 1 title: 'Theme'>
	^ ToSpaceThemeSpec new
		  space: self;
		  yourself
]

Extension { #name : #BlSpace }

{ #category : #'*Toplo-IDE' }
BlSpace >> inspectionTheme [

	<inspectorPresentationOrder: 1 title: 'Theme'>
"	^ ToSpaceThemeViewerSpec new
		  space: self;
		  yourself"
		^ ToSpaceThemeInspectorSpec new
		  space: self;
		  yourself
		
]

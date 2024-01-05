Extension { #name : #ToStyleRule }

{ #category : #'*Toplo-IDE' }
ToStyleRule >> inspectionStyleRule [

	<inspectorPresentationOrder: 1 title: 'Properties'>
	^ ToStyleRuleInspectorSpec new styleRule: self
]

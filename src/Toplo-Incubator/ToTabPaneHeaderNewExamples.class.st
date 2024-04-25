Class {
	#name : #ToTabPaneHeaderNewExamples,
	#superclass : #Object,
	#category : #'Toplo-Incubator'
}

{ #category : #header }
ToTabPaneHeaderNewExamples class >> example_header10Tab [

	| header |
	header := ToTabPaneHeaderNew new.
	1 to: 10 do: [ :count | header tabs dataAccessor add: (ToTabNew new data: 'Tab ', count asString). ].
	header background: Color yellow.
	header matchParent.
	header beHorizontal.
	header openInSpace.
	header inspect.
	^ header
]

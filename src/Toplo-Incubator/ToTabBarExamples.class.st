Class {
	#name : #ToTabBarExamples,
	#superclass : #Object,
	#category : #'Toplo-Incubator'
}

{ #category : #header }
ToTabBarExamples class >> example_header10Tab [

	| header |
	header := ToTabBarElement new.
	1 to: 10 do: [ :count | header tabs dataAccessor add: (ToTabModel new data: 'Tab ', count asString). ].
	header background: Color yellow.
	header hMatchParent.
	header tabs vFitContent.
	header tabs innerContainer vFitContent.
	header beHorizontal.
	header openInSpace.
	header inspect.
	^ header
]

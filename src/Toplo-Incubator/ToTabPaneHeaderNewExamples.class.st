Class {
	#name : 'ToTabPaneHeaderNewExamples',
	#superclass : 'Object',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'header' }
ToTabPaneHeaderNewExamples class >> example_headerFourTab [

	| header |
	header := ToTabPaneHeaderNew new.
	header tabs data add: (ToTabNew new data: 'Tab 1').
	header tabs data add: (ToTabNew new data: 'Tab 2').
	header tabs data add: (ToTabNew new data: 'Tab 3').
	header tabs data add: (ToTabNew new data: 'Tab 4').
	header background: Color yellow.
	header matchParent.
	header beVertical.
	header openInSpace.
	header inspect.
	^ header
]

"
A ToBasicWidgetTest is a test class for testing the behavior of ToBasicWidget
"
Class {
	#name : #ToBasicWidgetTest,
	#superclass : #ToTestCase,
	#category : #'Toplo-Tests-Core'
}

{ #category : #test }
ToBasicWidgetTest >> testModel [

	| widget |
	widget := ToBasicWidget new.
	self assert: widget model equals: widget.
]

Class {
	#name : #ToScrollableElement,
	#superclass : #BlScrollableElement,
	#traits : 'TToElement + TToEnableable + TBlLayoutResizable',
	#classTraits : 'TToElement classTrait + TToEnableable classTrait + TBlLayoutResizable classTrait',
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'t  - layout resizeable' }
ToScrollableElement >> resizableConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	
	Can be basically defined with #constraintsDo: aBlock.
	
	Introduced a an explicit requirement to let user
	implement additional actions when resizing is changed
	
	"
	| hr vr |
	hr := self constraints horizontal resizer.
	vr := self constraints vertical resizer.
	aBlock value: self constraints.
	(hr = self constraints horizontal resizer and: [
		 vr = self constraints vertical resizer ]) ifTrue: [ ^ self ].
	self dispatchEvent: ToLayoutConstraintsChangedEvent new.
	self requestLayout
]

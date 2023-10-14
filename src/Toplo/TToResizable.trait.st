Trait {
	#name : 'TToResizable',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 't - resizeable' }
TToResizable >> exact: aPoint [
	| aSize |
	
	aSize := aPoint asPoint.
	self hExact: aSize x.
	self vExact: aSize y
]

{ #category : 't - resizeable' }
TToResizable >> fitContent [
	self hFitContent.
	self vFitContent
]

{ #category : 't - resizeable' }
TToResizable >> fitContentLimited [
	self hFitContentLimited.
	self vFitContentLimited
]

{ #category : 't - resizeable' }
TToResizable >> hExact: aNumber [

	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"
	self resizableConstraintsDo: [ :c | c horizontal exact: aNumber ]
]

{ #category : 't - resizeable' }
TToResizable >> hFitContent [

	self resizableConstraintsDo: [ :c | c horizontal fitContent ]
]

{ #category : 't - resizeable' }
TToResizable >> hFitContentLimited [
	
	self resizableConstraintsDo: [ :c | c horizontal fitContentLimited ]
]

{ #category : 't - resizeable' }
TToResizable >> hMatchParent [
	
	self resizableConstraintsDo: [ :c | c horizontal matchParent ]
]

{ #category : 't - resizeable' }
TToResizable >> matchParent [
	self hMatchParent.
	self vMatchParent
]

{ #category : 't - resizeable' }
TToResizable >> resizableConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	
	Can be basically defined with #constraintsDo: aBlock.
	
	Introduced a an explicit requirement to let user
	implement additional actions when resizing is changed
	
	"
	self explicitRequirement 
]

{ #category : 't - resizeable' }
TToResizable >> vExact: aNumber [
	
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"
	self resizableConstraintsDo: [ :c | c vertical exact: aNumber ]
]

{ #category : 't - resizeable' }
TToResizable >> vFitContent [
	
	self resizableConstraintsDo: [ :c | c vertical fitContent ]
]

{ #category : 't - resizeable' }
TToResizable >> vFitContentLimited [
	
	self resizableConstraintsDo: [ :c | c vertical fitContentLimited ]
]

{ #category : 't - resizeable' }
TToResizable >> vMatchParent [
	
	self resizableConstraintsDo: [ :c | c vertical matchParent ]
]

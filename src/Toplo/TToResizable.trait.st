Trait {
	#name : #TToResizable,
	#category : #'Toplo-Core'
}

{ #category : #'t - layout resizeable' }
TToResizable >> exact: aPoint [
	| aSize |
	
	aSize := aPoint asPoint.
	self hExact: aSize x.
	self vExact: aSize y
]

{ #category : #'t - layout resizeable' }
TToResizable >> fitContent [
	self hFitContent.
	self vFitContent
]

{ #category : #'t - layout resizeable' }
TToResizable >> fitContentLimited [
	self hFitContentLimited.
	self vFitContentLimited
]

{ #category : #'t - layout resizeable' }
TToResizable >> hExact: aNumber [

	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"
	self resizableConstraintsDo: [ :c | c horizontal exact: aNumber ]
]

{ #category : #'t - layout resizeable' }
TToResizable >> hFitContent [

	self resizableConstraintsDo: [ :c | c horizontal fitContent ]
]

{ #category : #'t - layout resizeable' }
TToResizable >> hFitContentLimited [
	
	self resizableConstraintsDo: [ :c | c horizontal fitContentLimited ]
]

{ #category : #'t - layout resizeable' }
TToResizable >> hMatchParent [
	
	self resizableConstraintsDo: [ :c | c horizontal matchParent ]
]

{ #category : #'t - layout resizeable' }
TToResizable >> matchParent [
	self hMatchParent.
	self vMatchParent
]

{ #category : #'t - layout resizeable' }
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

{ #category : #'t - layout resizeable' }
TToResizable >> vExact: aNumber [
	
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"
	self resizableConstraintsDo: [ :c | c vertical exact: aNumber ]
]

{ #category : #'t - layout resizeable' }
TToResizable >> vFitContent [
	
	self resizableConstraintsDo: [ :c | c vertical fitContent ]
]

{ #category : #'t - layout resizeable' }
TToResizable >> vFitContentLimited [
	
	self resizableConstraintsDo: [ :c | c vertical fitContentLimited ]
]

{ #category : #'t - layout resizeable' }
TToResizable >> vMatchParent [
	
	self resizableConstraintsDo: [ :c | c vertical matchParent ]
]

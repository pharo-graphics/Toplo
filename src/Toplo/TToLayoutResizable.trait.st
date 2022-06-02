Trait {
	#name : #TToLayoutResizable,
	#category : #'Toplo-Core'
}

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> exact: aPoint [
	| aSize |
	
	aSize := aPoint asPoint.
	self hExact: aSize x.
	self vExact: aSize y
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> fitContent [
	self hFitContent.
	self vFitContent
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> fitContentLimited [
	self hFitContentLimited.
	self vFitContentLimited
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> hExact: aNumber [

	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"
	(self constraints horizontal resizer isExact
		and: [ self constraints horizontal resizer size = aNumber ])
			ifFalse: [ self constraintsDo: [ :c | c horizontal exact: aNumber ] ].

	self states addState: BrLayoutHorizontalResizerState exact
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> hFitContent [
	(self constraints horizontal resizer isFitContent)
		ifFalse: [ self constraintsDo: [ :c | c horizontal fitContent ] ].

	self states addState: BrLayoutHorizontalResizerState fitContent
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> hFitContentLimited [
	(self constraints horizontal resizer isFitContentLimited)
		ifFalse: [ self constraintsDo: [ :c | c horizontal fitContentLimited ] ].

	self states addState: BrLayoutHorizontalResizerState fitContentLimited
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> hLocal [
	self states addState: BrLayoutHorizontalResizerState local
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> hMatchParent [
	(self constraints horizontal resizer isMatchParent)
		ifFalse: [ self constraintsDo: [ :c | c horizontal matchParent ] ].

	self states addState: BrLayoutHorizontalResizerState matchParent
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> matchParent [
	self hMatchParent.
	self vMatchParent
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> vExact: aNumber [
	
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"
	(self constraints vertical resizer isExact
		and: [ self constraints vertical resizer size = aNumber ])
			ifFalse: [
				self constraintsDo: [ :c | c vertical exact: aNumber ] ].

	self states addState: BrLayoutVerticalResizerState exact
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> vFitContent [
	(self constraints vertical resizer isFitContent)
		ifFalse: [ self constraintsDo: [ :c | c vertical fitContent ] ].

	self states addState: BrLayoutVerticalResizerState fitContent
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> vFitContentLimited [
	(self constraints vertical resizer isFitContentLimited)
		ifFalse: [ self constraintsDo: [ :c | c vertical fitContentLimited ] ].

	self states addState: BrLayoutVerticalResizerState fitContentLimited
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> vLocal [
	self states addState: BrLayoutVerticalResizerState local
]

{ #category : #'api - layout resizeable' }
TToLayoutResizable >> vMatchParent [
	(self constraints vertical resizer isMatchParent)
		ifFalse: [ self constraintsDo: [ :c | c vertical matchParent ] ].

	self states addState: BrLayoutVerticalResizerState matchParent
]

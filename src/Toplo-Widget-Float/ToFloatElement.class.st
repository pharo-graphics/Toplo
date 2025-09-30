Class {
	#name : #ToFloatElement,
	#superclass : #ToBaseFloatElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #'attaching  / detaching' }
ToFloatElement >> attachToElement: anElement [

	self constraintsDo: [ :c | c ignoreByLayout ].
	anElement floatOverlay addChild: self
]

{ #category : #initialization }
ToFloatElement >> defaultOffset [

	^ 10 negated asPoint.

]

{ #category : #initialization }
ToFloatElement >> defaultPlacement [ 

	^ ToAnchoredAtBottomRight new
]

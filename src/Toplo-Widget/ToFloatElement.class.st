Class {
	#name : #ToFloatElement,
	#superclass : #ToBaseFloatElement,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToFloatElement >> applyConfiguration [

	super applyConfiguration.
	self isHMatchParent
		ifTrue: [ innerElement hMatchParent ]
		ifFalse: [ innerElement hFitContent ].
	self isVMatchParent
		ifTrue: [ innerElement vMatchParent ]
		ifFalse: [ innerElement vFitContent ]
]

{ #category : #'attaching  / detaching' }
ToFloatElement >> attachToElement: anElement [

	self constraintsDo: [ :c | c ignoreByLayout ].
	anElement floatOverlay addChild: self
]

{ #category : #accessing }
ToFloatElement >> builder: aValuable [

	aValuable value: innerElement 
]

{ #category : #initialization }
ToFloatElement >> defaultOffset [

	^ 10 negated asPoint.

]

{ #category : #initialization }
ToFloatElement >> defaultPlacement [ 

	^ ToAnchoredAtBottomRight new
]

{ #category : #initialization }
ToFloatElement >> initialize [ 

	super 	initialize.
	innerElement := self newInnerElement.
	innerElement constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	self addChild: innerElement.

]

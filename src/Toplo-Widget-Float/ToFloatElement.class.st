Class {
	#name : #ToFloatElement,
	#superclass : #ToAnchoredElement,
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

{ #category : #'attaching  / detaching' }
ToFloatElement >> detachFromElement [

	self removeFromParent
]

{ #category : #initialization }
ToFloatElement >> initialize [ 

	super initialize.
	self
		addEventHandlerOn: BlLayoutResizerChangedEvent
		do: [ :event | self requestConfiguration ].

	innerElement := ToElement new.
	innerElement constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	self addChild: innerElement.

]

{ #category : #'attaching  / detaching' }
ToFloatElement >> isAttached [

	^ self hasParent
]

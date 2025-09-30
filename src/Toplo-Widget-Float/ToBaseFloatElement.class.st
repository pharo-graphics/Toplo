Class {
	#name : #ToBaseFloatElement,
	#superclass : #ToAnchoredElement,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToBaseFloatElement >> applyConfiguration [

	super applyConfiguration.
	self isHMatchParent
		ifTrue: [ innerElement hMatchParent ]
		ifFalse: [ innerElement hFitContent ].
	self isVMatchParent
		ifTrue: [ innerElement vMatchParent ]
		ifFalse: [ innerElement vFitContent ]
]

{ #category : #accessing }
ToBaseFloatElement >> builder: aValuable [

	aValuable value: innerElement 
]

{ #category : #'attaching  / detaching' }
ToBaseFloatElement >> detachFromElement [

	self removeFromParent
]

{ #category : #initialization }
ToBaseFloatElement >> initialize [ 

	super initialize.
	self
		addEventHandlerOn: BlLayoutResizerChangedEvent
		do: [ :event | self requestConfiguration ].

	innerElement := self newInnerElement.
	innerElement constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	self addChild: innerElement.

]

{ #category : #'attaching  / detaching' }
ToBaseFloatElement >> isAttached [

	^ self hasParent
]

{ #category : #initialization }
ToBaseFloatElement >> newInnerElement [ 

	^ ToElement new
]

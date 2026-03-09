Class {
	#name : #ToBaseFloatElement,
	#superclass : #ToAnchoredElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #accessing }
ToBaseFloatElement >> builder: aValuable [

	aValuable value: self 
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
		do: [ :event | self requestConfiguration ]
]

{ #category : #'attaching  / detaching' }
ToBaseFloatElement >> isAttached [

	^ self hasParent
]

{ #category : #initialization }
ToBaseFloatElement >> newInnerElement [ 

	^ ToElement new
]

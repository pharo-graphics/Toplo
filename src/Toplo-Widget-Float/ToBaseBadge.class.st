Class {
	#name : #ToBaseBadge,
	#superclass : #ToAnchoredElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #'attaching  / detaching' }
ToBaseBadge >> attachToElement: anElement [

	self constraintsDo: [ :c | c ignoreByLayout ].
	anElement addEventHandler: (ToBadgedElementEventHandler new
			 badge: self;
			 yourself)
]

{ #category : #accessing }
ToBaseBadge >> builder: aValuable [

	aValuable value: self
]

{ #category : #initialization }
ToBaseBadge >> defaultOffset [

	^ 10 @ 10
]

{ #category : #initialization }
ToBaseBadge >> defaultPlacement [ 

	^ ToAnchoredAtTopRight new
]

{ #category : #'attaching  / detaching' }
ToBaseBadge >> detachFromElement [

	self referenceElement dispatchEvent: (ToBadgeDetachedEvent new
			 badge: self;
			 yourself).
	self constraintsDo: [ :c | c accountByLayout ]. 

]

{ #category : #'attaching  / detaching' }
ToBaseBadge >> isAttached [

	^ self referenceElement notNil
]

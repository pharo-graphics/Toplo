Class {
	#name : #ToBaseBadge,
	#superclass : #ToAnchoredElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #'attaching  / detaching' }
ToBaseBadge >> attachToElement: anElement [

	anElement addEventHandler: (ToBadgedElementEventHandler new
			 badge: self;
			 yourself)
]

{ #category : #'attaching  / detaching' }
ToBaseBadge >> detachFromElement [

	self referenceElement dispatchEvent: (ToBadgeDetachedEvent new
			 badge: self;
			 yourself)
]

{ #category : #'attaching  / detaching' }
ToBaseBadge >> isAttached [

	^ self referenceElement notNil
]

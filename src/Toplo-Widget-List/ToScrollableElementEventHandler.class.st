Class {
	#name : #ToScrollableElementEventHandler,
	#superclass : #BlEventListener,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'mouse handlers' }
ToScrollableElementEventHandler >> mouseWheelEvent: anEvent [
	
	"I implement touch support, so ignore fake mouse wheel events"
	anEvent isTouch
		ifTrue: [ ^ self ].

	anEvent currentTarget smoothScrollBy: (anEvent vector * BlInfiniteMouseScrollListener scrollingVelocity ) negated.
	anEvent consume
]

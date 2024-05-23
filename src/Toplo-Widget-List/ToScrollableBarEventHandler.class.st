Class {
	#name : #ToScrollableBarEventHandler,
	#superclass : #BlEventListener,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'mouse handlers' }
ToScrollableBarEventHandler >> mouseWheelEvent: anEvent [
	
	"I implement touch support, so ignore fake mouse wheel events"
	anEvent isTouch
		ifTrue: [ ^ self ].

	anEvent currentTarget smoothScrollBy: (anEvent vector * BlInfiniteMouseScrollListener scrollingVelocity ) negated.
	anEvent consume
]

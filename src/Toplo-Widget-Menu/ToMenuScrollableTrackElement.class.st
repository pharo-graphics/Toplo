Class {
	#name : #ToMenuScrollableTrackElement,
	#superclass : #ToScrollableFiniteListTrackElement,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #configuration }
ToMenuScrollableTrackElement >> applyConfiguration [

	super applyConfiguration.
	self childrenDo: [ :child |
			child constraintsDo: [ :c |
					listElement isHorizontal
						ifTrue: [ 
							c frame vertical alignCenter.
							c linear vertical alignCenter ]
						ifFalse: [ 
							c linear horizontal alignCenter.
							c linear horizontal alignCenter ] ] ]
]

{ #category : #layout }
ToMenuScrollableTrackElement >> flowLayoutClass [

	^ ToMenuListFlowLayout 
]

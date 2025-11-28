Class {
	#name : #ToMenuScrollableBarTrackElement,
	#superclass : #ToScrollableBarTrackElement,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #configuration }
ToMenuScrollableBarTrackElement >> applyConfiguration [

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
ToMenuScrollableBarTrackElement >> flowLayoutClass [

	^ ToMenuBarFlowLayout 
]

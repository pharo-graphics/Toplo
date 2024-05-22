Class {
	#name : #ToBarNode,
	#superclass : #ToNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToBarNode >> autoDistribute: aBoolean [

	aBoolean
		ifTrue: [
			self constraintsDo: [ :c |
				self holder listElement isHorizontal
					ifTrue: [ c horizontal matchParent ]
					ifFalse: [ c vertical matchParent ] ] ]
		ifFalse: [ self setInitialLayoutConstraints ]
]

{ #category : #initialization }
ToBarNode >> setInitialLayoutConstraints [

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

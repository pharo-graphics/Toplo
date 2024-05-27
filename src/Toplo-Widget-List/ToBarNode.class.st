Class {
	#name : #ToBarNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToBarNode >> setInitialConfiguration [

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

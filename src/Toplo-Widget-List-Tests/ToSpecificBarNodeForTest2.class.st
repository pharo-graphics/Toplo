Class {
	#name : #ToSpecificBarNodeForTest2,
	#superclass : #ToListNode,
	#traits : 'TToBarNode',
	#classTraits : 'TToBarNode classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-BarElement'
}

{ #category : #initialization }
ToSpecificBarNodeForTest2 >> initialize [ 

	super initialize.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

Class {
	#name : #ToSpecificBarNodeForTest,
	#superclass : #ToListNode,
	#traits : 'TToBarNode',
	#classTraits : 'TToBarNode classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-BarElement'
}

{ #category : #initialization }
ToSpecificBarNodeForTest >> initialize [ 

	super initialize.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #'t - labeled icon' }
ToSpecificBarNodeForTest >> labelText [ 

	^ self holder num asString, ':', self holder dataItem asString
]

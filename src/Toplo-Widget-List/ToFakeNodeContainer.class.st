Class {
	#name : #ToFakeNodeContainer,
	#superclass : #ToElement,
	#instVars : [
		'nodeContainer'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToFakeNodeContainer >> applyConfiguration [

	super applyConfiguration.
	[ nodeContainer applyConfiguration ]
		on: Error
		do: [ :error |
				'*** Warning: can''t apply configuration on fake node container: '
					trace.
				error traceCr ].
	self holder listElement isHorizontal
		ifTrue: [ self width: 0 ]
		ifFalse: [ self height: 0 ]
]

{ #category : #testing }
ToFakeNodeContainer >> isFake [ 

	^ true
]

{ #category : #accessing }
ToFakeNodeContainer >> node [ 

	^ nodeContainer node
]

{ #category : #accessing }
ToFakeNodeContainer >> nodeContainer [

	^ nodeContainer
]

{ #category : #accessing }
ToFakeNodeContainer >> nodeContainer: aNodeContainer [

	nodeContainer := aNodeContainer.
	self addChild: aNodeContainer
]

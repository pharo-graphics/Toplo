Class {
	#name : #ToFakeNodeContainerWrapper,
	#superclass : #ToElement,
	#instVars : [
		'nodeContainer'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #configuration }
ToFakeNodeContainerWrapper >> applyConfiguration [

	super applyConfiguration.
	[ nodeContainer applyConfiguration ]
		on: Error
		do: [ :error |
				'*** Warning: can''t apply configuration on fake node container: '
					trace.
				error traceCr ]
]

{ #category : #initialization }
ToFakeNodeContainerWrapper >> initialize [

	super initialize.
	self id: #fakeNodeContainerWrapper
]

{ #category : #accessing }
ToFakeNodeContainerWrapper >> node [ 

	^ nodeContainer node
]

{ #category : #accessing }
ToFakeNodeContainerWrapper >> nodeContainer [

	^ nodeContainer
]

{ #category : #accessing }
ToFakeNodeContainerWrapper >> nodeContainer: aNodeContainer [

	nodeContainer := aNodeContainer.
	self addChild: aNodeContainer
]

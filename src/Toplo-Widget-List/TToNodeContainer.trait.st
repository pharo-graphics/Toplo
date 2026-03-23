Trait {
	#name : #TToNodeContainer,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - node container' }
TToNodeContainer >> listElement [ 

	^ self holder listElement
]

{ #category : #'t - node container - requirements' }
TToNodeContainer >> node [ 

	^ self shouldBeImplemented 
]

{ #category : #'t - node container' }
TToNodeContainer >> nodeManager [ 

	^ self listElement nodeManager
]
